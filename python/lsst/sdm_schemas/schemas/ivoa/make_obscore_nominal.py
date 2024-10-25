# This file is part of sdm_schemas/yml/ivoa.
#
# Developed for the LSST Data Management System.
# This product includes software developed by the LSST Project
# (https://www.lsst.org).
# See the COPYRIGHT file at the top-level directory of this distribution
# for details of code ownership.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

"""Generator for Felis for the nominal ObsCore data model

This stand-alone program takes tabular data on the columns in the
ObsTAP realization of the ObsCore data model, taken directly from
the IVOA ObsCore standard, with errata applied, and converted to
CSV, and produces a Rubin-flavored "Felis" description in YAML of
the data model. The result is intended to be used as input to the
creation of operation Felis descriptions of ObsCore-formatted
tables on RSP services.

Output is produced to stdout and is intended to be redirected to a file.
"""

import argparse
import csv

def to_yaml( text: str ) -> str:
    """Rough conversion of a string to an acceptable format for YAML.

    Currently only handles issues actually arising in the ObsCore table descriptions.
    As of this writing only the colon-followed-by-space rule is considered, and
    in that case the string is simply wrapped in double quotes.

    Parameters
    ----------
    text : `str`
        String to be converted.

    Returns
    -------
    yamltext : `str`
        String in an acceptable YAML format.
    """
    if ": " in text:
        return "\"" + text + "\""
    else:
        return text

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Produce Felis YAML for ObsCore attributes in the ObsTAP realization",
        epilog="If no attribute list is provided, creates YAML for the entire"
               " set of defined ObsCore attributes in the standard,"
               " with optional attributes noted." )
    parser.add_argument('attr_file', nargs='?', default='',
        help="File with list of attributes to be used, one name per line (default: all)")
    args = parser.parse_args()

    # Note the four key ObsCore attributes that must be NOT NULL (in v1.1).
    not_null = ['calib_level', 'obs_collection', 'obs_id', 'obs_publisher_did']

    # First, process Table 5 from the standard, which is primarily valuable
    # for containing text descriptions of each column in the model.
    desc_data = dict()
    with open('ObsCore-v1.1-descriptions.csv', newline='') as desc_file:
        desc_reader = csv.DictReader(desc_file)
        for r in desc_reader:
            if r['Column Name'] in desc_data:
                raise RuntimeError( "Duplicate record in descriptions: " + repr(r) )
            desc_data[r['Column Name']] = r

    # Second, process Tables 6 and 7, which provide the more reliable detailed
    # specifications of type, UCD, Utype, and so on.
    col_data = dict()
    with open('ObsCore-v1.1-mandatory.csv', newline='') as col_file:
        col_reader = csv.DictReader(col_file)
        for r in col_reader:
            if r['Column Name'] in col_data:
                raise RuntimeError( "Duplicate record in definitions: " + repr(r) )
            r['optional'] = False  # Table 6 attributes are mandatory
            col_data[r['Column Name']] = r

    with open('ObsCore-v1.1-optional.csv', newline='') as col_file:    
        col_reader = csv.DictReader(col_file)  
        for r in col_reader: 
            if r['Column Name'] in col_data: 
                raise RuntimeError( "Duplicate record in optional definitions: " + repr(r) )
            r['optional'] = True  # Table 7 attributes are optional
            col_data[r['Column Name']] = r 

    # Process arguments to determine which attributes to emit.
    # Default: output all attributes and mark optional ones.
    col_list = col_data.keys()
    mark_opt = True

    # If a file was supplied, take the first token in each row as an attribute name.
    if args.attr_file != '':
        with open(args.attr_file, newline='') as attr_file:
            mark_opt = False
            attr_reader = csv.reader(attr_file)
            col_list = [ attr_row[0] for attr_row in attr_reader ]
            if len(col_list) < 1:
                raise RuntimeError( "No attributes found in file '" + args.attr_file + "'" )

    #TODO - validate the list to ensure it contains only known attributes,
    #       and all the mandatory ones.

    # Add a Felis-compatible datatype mapping from the types provided in the Table 5 data
    # TODO - this doesn't handle all cases yet, especially "date"
    felis_types = { "enum int":    ("int", 1),
                    "integer":     ("long", 1),
                    "enum string": ("char", '"*"'),
                    "string":      ("char", '"*"'),
                    "String":      ("char", '"*"'),
                    "double":      ("double", 1) }

    # emit file-level header describing the file and the single table it defines
    print("---\n"
          "name: ivoa\n"
          "\"@id\": \"#ivoa_obscore\"\n"
          "description: ObsCore v1.1 attributes in ObsTAP realization\n"
          "tables:\n"
          "- name: ObsCore\n"
          "  \"@id\": \"#ObsCore\"\n"
          "  description: Observation metadata in the ObsTAP relational realization of\n"
          "    the IVOA ObsCore data model\n"
          "  columns:"
          )

    # Loop over columns in the data model and emit the paragraphs for each one.
    # The keys for the various properties are a bit arbitrary as to whether they
    # have "ivoa:", "tap:", etc. prefixes.  This is what is currently required
    # in Felis processing.
    for col in col_list:
        print(
              "  - name: " + col +
                   ("  # (optional)" if mark_opt and col_data[col]['optional'] else "") + "\n"
              "    \"@id\": \"ObsCore." + col + "\"\n"
              "    description: " + to_yaml(desc_data[col]['Description']) + "\n"
              "    nullable: " + ( "false" if col in not_null else "true" ) + "\n"
              "    ivoa:ucd: " + col_data[col]['UCD'] + "\n"
              "    votable:utype: " + col_data[col]['ObsCoreDM Utype'] + "\n"
              "    tap:std: " + col_data[col]['Std'] + "\n"
              "    tap:principal: " + col_data[col]['Principal']
              )

        # In the ObsCore document, from which the CSV files were copied, columns with
        # suggested null values have the string "NULL", which we should not emit into Felis.
        col_units = col_data[col]['Units']
        if col_units == 'NULL':
            print(
                  "    ivoa:unit:"
                 )
        else:
            print(
                  "    ivoa:unit: " + col_units
                 )

        # Output the data type, which may be an array
        ftype = felis_types[desc_data[col]["Type"]]
        if ftype[1] == 1:
            print(
                  "    datatype: " + ftype[0]
                 )
        else:
            print(
                  "    datatype: " + ftype[0] + "\n"
                  "    votable:arraysize: " + ftype[1]
                 )
