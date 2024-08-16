#!/bin/bash

usage() {
    echo "Usage: <database> [output-directory]"
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
    echo "Error: Invalid database type. Please use one of 'postgresql', 'mysql', or 'sqlite'."
    exit 1
fi

if [[ -z "$2" ]];
then
    outputdir="sql"
else
    outputdir=$2
fi

if [[ ! -d "$outputdir" ]];
then
    mkdir -p $outputdir &> /dev/null
fi

echo "Creating SQL files for $database in directory $outputdir..."

# Initialize a variable to track if any command fails
error_occurred=0

for yaml_file in yml/*.yaml; do
  echo "Creating SQL from $yaml_file..."
  felis --log-level ERROR create --ignore-constraints --engine-url=${database}:// \
      --output-file $outputdir/"$(basename "$yaml_file" .yaml).sql" $yaml_file
  # Check if the felis command was successful
  if [ $? -ne 0 ]; then
      echo "Error: Failed to create SQL from $yaml_file"
      error_occurred=1
  else
      echo "Done creating SQL from $yaml_file"
  fi
done

echo "Done creating SQL files for $database in directory $outputdir"

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to create all SQL files for $database"
    exit 1
fi
