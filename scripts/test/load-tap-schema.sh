#!/bin/bash

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
else
    echo "Error: FELIS_ENGINE_URL protocol must be one of 'mysql', 'postgresql' or 'sqlite'"
    exit 1
fi

echo "Detected database type: $database"

error_occurred=0

for yaml_file in yml/*.yaml; do
    filename=$(basename "$yaml_file")
    echo "Loading TAP_SCHEMA from $yaml_file"
    set +e
    felis --log-level ERROR init-tap-schema --engine-url ${FELIS_ENGINE_URL}
    if [ $? -ne 0 ]; then
        echo "Error: Failed to initialize TAP schema from $yaml_file"
        error_occurred=1
    fi
    felis --log-level ERROR load-tap-schema --engine-url ${FELIS_ENGINE_URL} "$yaml_file"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to load TAP schema from $yaml_file"
        error_occurred=1
    fi
    set -e
    # Drop the TAP_SCHEMA database or schema
    if [[ "$database" == "mysql" ]]; then
        mysql -e "DROP DATABASE TAP_SCHEMA;"
    elif [[ "$database" == "postgresql" ]]; then
        psql -c "DROP SCHEMA \"TAP_SCHEMA\" CASCADE;"
    elif [[ "$database" == "sqlite" ]]; then
        rm TAP_SCHEMA.db
    fi
    echo "Done loading TAP_SCHEMA from $yaml_file"
done

if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all schemas into TAP_SCHEMA using $database"
    exit 1
fi
