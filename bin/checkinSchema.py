#!/usr/bin/env python

import optparse
import os
import re
import subprocess
import sys

LSSTheader = """
-- LSST Database Schema
-- $Author$
-- $Revision$
-- $Date$
--
-- See <http://lsstdev.ncsa.uiuc.edu:8100/trac/wiki/Copyrights>
-- for copyright information.

"""

usage = """%prog schemaFile_{version}.sql [-m {message}]

Everything between the first underscore and a trailing ".sql" in the argument
filename is taken as a version string.  Any non-alphanumeric characters in the
version string are translated to underscores ("_").

A "CREATE TABLE AAA_Version_{version}" statement is prepended to the file.
A standard header is also prepended.

The file is renamed without the underscore and version string.  Any end of
line characters in the file are translated to the current system's standard.

The file is then checked into SVN using the optional message if present.
"""

parser = optparse.OptionParser(usage)
parser.add_option("-m")
options, arguments = parser.parse_args()

if len(arguments) != 1:
    sys.stderr.write(os.path.basename(sys.argv[0]) + usage[6:])
    sys.exit(1)
filename = arguments[0]

pos = filename.find("_")
if pos == -1 or filename[-4:] != ".sql":
    sys.stderr.write(os.path.basename(sys.argv[0]) + usage[6:])
    sys.exit(1)

origVersion = filename[pos + 1:-4]
r = re.compile(r'\W')
version = r.sub("_", origVersion)

destFilename = filename[0:pos] + ".sql"

src = open(filename, mode='rU')
dest = open(destFilename, mode='wt')

dest.write(LSSTheader)
dest.write("\nCREATE TABLE AAA_Version_" + version + " (version CHAR);\n\n")
dest.writelines(src)

src.close()
dest.close()

# Don't delete the original, just in case there's a problem.
# os.unlink(filename)

message = "LSST schema version " + origVersion + "."
if options.m != None:
    message += " " + options.m

subprocess.call(["svn", "commit", destFilename, "-m", message])
