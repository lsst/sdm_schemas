#!/bin/bash

if [[ -z "$1" ]];
then
  sql_dir="sql"
else
  sql_dir=$1
fi

if [[ ! -d "$sql_dir" ]];
then
  echo "Error: SQL directory $sql_dir does not exist. Please run scripts/generate-sql-files.sh first."
  exit 1
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
    psql -c "DROP SCHEMA IF EXISTS \"${db_name}\" CASCADE;" &> /dev/null
    psql -c "CREATE SCHEMA \"${db_name}\";" &> /dev/null
    psql -q < "$sql_file"
    # Check if the psql command was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to load SQL from $sql_file"
        error_occurred=1
    else
        echo "Done loading SQL from $sql_file"
    fi
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all SQL files into MySQL"
    exit 1
fi
