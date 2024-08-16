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
    FELIS_ENGINE_URL="${FELIS_ENGINE_URL}/TAP_SCHEMA"
elif [[ "$protocol" == *"postgresql"* ]]; then
    database="postgresql"
elif [[ "$protocol" == *"sqlite"* ]]; then
    database="sqlite"
    FELIS_ENGINE_URL="sqlite:///TAP_SCHEMA.db"
else
    echo "Error: FELIS_ENGINE_URL protocol must contain one of 'mysql', 'postgresql' or 'sqlite'."
    exit 1
fi

# Initialize a variable to track if any command fails
error_occurred=0

for yaml_file in yml/*.yaml; do
    filename=$(basename "$yaml_file")
    echo "Uploading to TAP_SCHEMA from $yaml_file..."
    felis --log-level ERROR load-tap --engine-url ${FELIS_ENGINE_URL} "$yaml_file"
    # Check if the felis command was successful
    if [ $? -ne 0 ]; then
      echo "Error: Failed to create SQL from $yaml_file"
      error_occurred=1
    else
      echo "Done uploading to TAP_SCHEMA from $yaml_file"
    fi
    if [[ "$database" == "mysql" ]]; then
        mysql -DTAP_SCHEMA -e "
            DELETE FROM \`columns\`;
            DELETE FROM \`key_columns\`;
            DELETE FROM \`keys\`;
            DELETE FROM \`schemas\`;
            DELETE FROM \`tables\`;
        " &> /dev/null
    elif [[ "$database" == "postgresql" ]]; then
        psql -q -c "TRUNCATE TABLE columns, key_columns, keys, schemas, tables;" &> /dev/null
    elif [[ "$database" == "sqlite" ]]; then
        sqlite3 TAP_SCHEMA.db "DELETE FROM columns;
            DELETE FROM key_columns;
            DELETE FROM keys;
            DELETE FROM schemas;
            DELETE FROM tables;
        " &> /dev/null
    fi
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all schemas into TAP_SCHEMA for $database"
    exit 1
fi
