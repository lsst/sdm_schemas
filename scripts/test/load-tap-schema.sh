#!/bin/bash

set -e
# set -x

# Check if FELIS_ENGINE_URL is set
if [ -z "$FELIS_ENGINE_URL" ]; then
    echo "Error: FELIS_ENGINE_URL is not set. Please set the environment variable and try again."
    exit 1
fi

# Determine the database type from FELIS_ENGINE_URL
protocol=$(echo "$FELIS_ENGINE_URL" | awk -F '://' '{print $1}')

if [[ "$protocol" == *"mysql"* ]]; then
    database="mysql"
elif [[ "$protocol" == *"postgresql"* ]]; then
    database="postgresql"
elif [[ "$protocol" == *"sqlite"* ]]; then
    database="sqlite"
    FELIS_ENGINE_URL="sqlite:///TAP_SCHEMA.db"
else
    echo "Error: FELIS_ENGINE_URL protocol must be one of 'mysql', 'postgresql' or 'sqlite'"
    exit 1
fi

echo "Detected database type: $database"

# Initialize a variable to track if any command fails
error_occurred=0

for yaml_file in yml/*.yaml; do
    filename=$(basename "$yaml_file")
    echo "Loading TAP_SCHEMA from $yaml_file..."
    felis --log-level ERROR init-tap-schema --engine-url ${FELIS_ENGINE_URL}
    felis --log-level ERROR load-tap-schema --engine-url ${FELIS_ENGINE_URL} "$yaml_file"
    # Drop the TAP_SCHEMA database or schema
    if [[ "$database" == "mysql" ]]; then
        echo "Dropping TAP_SCHEMA mysql database..."
        mysql -e "DROP DATABASE TAP_SCHEMA;"
    elif [[ "$database" == "postgresql" ]]; then
        echo "Dropping TAP_SCHEMA postgresql schema..."
        psql -c "DROP SCHEMA \"TAP_SCHEMA\" CASCADE;"
    elif [[ "$database" == "sqlite" ]]; then
        echo "Dropping TAP_SCHEMA sqlite database..."
        rm TAP_SCHEMA.db
    fi
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all schemas into TAP_SCHEMA for $database"
    exit 1
fi
