#!/usr/bin/env python

import re
import sys

usage = """%prog < EA_export.xml > metadata.sql

The XML on stdin is translated into SQL on stdout for creating and loading
the catalog metadata tables with descriptions of each table and column in
the catalog.
"""

# Tagged values for columns in EA that map directly to fields in the metadata.
columnTags = ["description", "type", "ucd", "unit"]

# Tagged values for columns in EA that need renaming.
remapTags = {"duplicates" : "notNull"}

# Fields for tables in the metadata (values obtained with custom code).
tableFields = ["engine",  "description"]

# Fields for columns in the metadata.
columnFields = ["description", "type", "notNull", "defaultValue",
    "unit", "ucd", "displayOrder"]

# Fields with numeric contents.
numericFields = ["notNull", "displayOrder"]

schema = """
CREATE TABLE md_Table (
	id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	name VARCHAR(255) NOT NULL UNIQUE,
	engine VARCHAR(255),
	description VARCHAR(255)
);

CREATE TABLE md_Column (
	id INTEGER NOT NULL UNIQUE PRIMARY KEY,
	tableId INTEGER NOT NULL REFERENCES md_Table (id),
	name VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	type VARCHAR(255),
	notNull INTEGER DEFAULT 0,
	defaultValue VARCHAR(255),
	unit VARCHAR(255),
	ucd VARCHAR(255),
        displayOrder INTEGER NOT NULL,
	INDEX md_Column_idx (tableId, name)
);

"""

###############################################################################

in_class = None
in_attr = None
type = ""
table = {}

classStart = re.compile(
    r'<UML:Class name="(\w+)" xmi.id="(\w+)" .* isRoot="false"')
classEnd = re.compile(r'</UML:Class>')
attrStart = re.compile(r'<UML:Attribute name="(\w+)"')
attrEnd = re.compile(r'</UML:Attribute>')
tag = re.compile(r'<UML:TaggedValue tag="(.+?)" value="(.+?)"')
expr = re.compile(r'<UML:Expression body="(.+?)"')
engineTag = re.compile(
  r'<UML:TaggedValue tag="(Type|ENGINE)" .* value="(.+?)" modelElement="(\w+)"')

colNum = 1
line = sys.stdin.readline()

while line != "":

    m = classStart.search(line)
    if m is not None:
        if m.group(2) not in table:
            table[m.group(2)] = {}
        table[m.group(2)]["name"] = m.group(1)
        colNum = 1
        in_class = table[m.group(2)]
    elif classEnd.search(line):
        in_class = None

    if in_class is None:

        m = engineTag.search(line)
        if m is not None:
            table[m.group(3)]["engine"] = m.group(2)

    else:

        m = attrStart.search(line)
        if m is not None:
            in_attr = {"name" : m.group(1)}
            in_attr["displayOrder"] = str(colNum)
            colNum += 1
            if "columns" not in in_class:
                in_class["columns"] = []
            in_class["columns"].append(in_attr)
        elif attrEnd.search(line):
            in_attr = None

        m = tag.search(line)
        if in_attr is None:
            if m is not None and m.group(1) == "documentation":
                in_class["description"] = m.group(2)
        else:
            if m is not None:
                if m.group(1) in columnTags:
                    in_attr[m.group(1)] = m.group(2)
                elif m.group(1) in remapTags:
                    in_attr[remapTags[m.group(1)]] = m.group(2)
                elif m.group(1) == "length":
                    if in_attr["type"] == "CHAR" or \
                            in_attr["type"] == "VARCHAR":
                        in_attr["type"] += "(" + m.group(2) + ")"
            else:
                m = expr.search(line)
                if m is not None:
                    in_attr["defaultValue"] = m.group(1)

    line = sys.stdin.readline()

###############################################################################

def handleField(ptr, field, indent):
    if field not in ptr:
        return
    q = '"'
    if field in numericFields:
        q = ''
    sys.stdout.write(",\n")
    sys.stdout.write("".join(["\t" for i in xrange(indent)]))
    sys.stdout.write(field + " = " + q + ptr[field] + q)

sys.stdout.write("".join(["-- " for i in xrange(25)]) + "\n")
sys.stdout.write("-- Create metadata tables\n" + schema)

tableId = 0
colId = 0
for k in sorted(table.keys(), key=lambda x: table[x]["name"]):
    t = table[k]
    tableId += 1
    sys.stdout.write("".join(["-- " for i in xrange(25)]) + "\n\n")
    sys.stdout.write("INSERT INTO md_Table\n")
    sys.stdout.write('SET id = %d, name = "%s"' % (tableId, t["name"]))
    for f in tableFields:
        handleField(t, f, 1)
    sys.stdout.write(";\n\n")

    if "columns" in t:
        for c in t["columns"]:
            colId += 1
            sys.stdout.write("\tINSERT INTO md_Column\n")
            sys.stdout.write('\tSET id = %d, tableId = %d, name = "%s"' %
                    (colId, tableId, c["name"]))
            for f in columnFields:
                handleField(c, f, 2)
            sys.stdout.write(";\n\n")
