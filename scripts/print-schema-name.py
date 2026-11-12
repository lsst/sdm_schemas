#!/usr/bin/env python
"""Print the name of a schema from its Felis YAML file."""

import argparse

from felis.datamodel import Schema


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("schema_file", help="Path to the Felis YAML schema file")
    args = parser.parse_args()
    schema = Schema.from_uri(args.schema_file, context={"id_generation": True})
    print(schema.name)


if __name__ == "__main__":
    main()
