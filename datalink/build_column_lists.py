"""From the Felis source files, build YAML of principal column names."""

from __future__ import annotations

import sys
from collections import defaultdict
from pathlib import Path
from typing import Dict, Any, List

import yaml


def filter_columns(table: Dict[str, Any], filter_key: str) -> List[str]:
    """Find the principal columns for a table.

    This respects the TAP v1.1 convention for ordering of columns.  All
    columns without ``tap:column_index`` set will be sorted after all those
    with it set, in the order in which they appeared in the Felis file.

    Parameters
    ----------
    table : Dict[`str`, Any]
        Felis definition of a table.
    filter_key : `str`
        Felis key to use to find columns of interest.  For example, use
        ``tap:principal`` to find principal columns.

    Returns
    -------
    columns : List[`str`]
        List of filtered columns in sorted order.
    """
    principal = []
    unknown_column_index = 100000000
    for column in table["columns"]:
        if column.get(filter_key):
            column_index = column.get("tap:column_index", unknown_column_index)
            unknown_column_index += 1
            principal.append((column["name"], column_index))
    return [c[0] for c in sorted(principal, key=lambda c: c[1])]


def build_columns(
    felis: Dict[str, Any], column_properties: List[str]
) -> Dict[str, Dict[str, List[str]]]:
    """Find the list of tables with a particular Felis property.

    Parameters
    ----------
    felis : Dict[`str`, Any]
        The parsed Felis YAML.
    column_properties : `str`
        The column properties to search for.
    """
    schema = felis["name"]
    output: Dict[str, Dict[str, List[str]]] = defaultdict(dict)
    for table in felis["tables"]:
        name = table["name"]
        full_name = f"{schema}.{name}"
        for column_property in column_properties:
            columns = filter_columns(table, column_property)
            output[full_name][column_property] = columns
    return output


def process_files(files: List[Path]) -> None:
    """Process a set of Felis input files and print output to standard out.

    Parameters
    ----------
    files : List[`pathlib.Path`]
        List of input files.

    Output
    ------
    The YAML version of the output format will look like this:

    .. code-block:: yaml

       tables:
         dp02_dc2_catalogs.ForcedSourceOnDiaObject:
           tap:principal:
             - band
             - ccdVisitId
    """
    tables = {}
    for input_file in files:
        with input_file.open("r") as fh:
            felis = yaml.safe_load(fh)
        tables.update(build_columns(felis, ["tap:principal"]))

    # Dump the result to standard output.
    print(yaml.dump({"tables": tables}))


def main() -> None:
    """Entry point."""
    process_files([Path(f) for f in sys.argv[1:]])


if __name__ == "__main__":
    main()
