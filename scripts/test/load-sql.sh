#!/bin/bash

###########################################################
# Load SQL files into a database to test if they are valid
###########################################################

usage() {
    echo "Usage: $0 <database> [sql_dir]"
    echo "Arguments:"
    echo "  <database>  The type of database to use. Must be one of 'postgresql', 'mysql', or 'sqlite'."
    echo "  [sql_dir]   Optional. The directory containing the SQL files. Defaults to 'sql'."
    exit 1
}

if [[ -z "$1" ]];
then
    usage
else
    database=$1
fi

# Validate the database argument
if [[ "$database" != "postgresql" && "$database" != "mysql" && "$database" != "sqlite" ]]; then
    echo "Error: Invalid database type $database."
    usage
fi

if [[ -z "$2" ]];
then
  sql_dir="sql"
else
  sql_dir=$1
fi

if [[ ! -d "$sql_dir" ]];
then
  echo "Error: SQL directory $sql_dir does not exist. Please run scripts/generate-sql-files.sh first."
  usage
fi

# Initialize a variable to track if any command fails
error_occurred=0

for yaml_file in yml/*.yaml; do
    echo "Loading SQL for ${yaml_file}..."
    sql_file="$sql_dir/$(basename "$yaml_file" .yaml).sql"
    if [[ ! -f "$sql_file" ]]; then
        echo "SQL file $sql_file does not exist. Skipping."
        continue
    fi
    db_name=$(yq e '.name' "$yaml_file")

    if [[ "$database" == "mysql" ]]; then
        mysql -e "DROP DATABASE IF EXISTS ${db_name};"
        mysql -e "CREATE DATABASE ${db_name};"
        mysql -q < "$sql_file"
    elif [[ "$database" == "postgresql" ]]; then
        psql -c "DROP SCHEMA IF EXISTS \"${db_name}\" CASCADE;" &> /dev/null
        psql -c "CREATE SCHEMA \"${db_name}\";" &> /dev/null
        psql -q < "$sql_file"
    elif [[ "$database" == "sqlite" ]]; then
        rm -f "${db_name}.db" &> /dev/null
        sqlite3 "${db_name}.db" < "$sql_file"
    fi

    # Check if the command was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to load SQL from $sql_file"
        error_occurred=1
    else
        echo "Done loading SQL from $sql_file"
    fi
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all SQL files into ${database}"
    exit 1
fi
