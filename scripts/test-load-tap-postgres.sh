#!/bin/bash

# Initialize a variable to track if any command fails
error_occurred=0

# Upload to TAP_SCHEMA database. Clear the tables after each upload to avoid
# conflicts between schemas.
for yaml_file in yml/*.yaml; do
    filename=$(basename "yaml_file" .yaml)
    echo "Uploading to TAP_SCHEMA from $yaml_file..."
    felis --log-level ERROR load-tap "$yaml_file"
    # Check if the felis command was successful
    if [ $? -ne 0 ]; then
      echo "Error: Failed to create SQL from $file"
      error_occurred=1
    else
      echo "Done creating SQL from $yaml_file"
    fi
    psql -q -c "TRUNCATE TABLE columns, key_columns, keys, schemas, tables;" &> /dev/null
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all schemas into TAP_SCHEMA"
    exit 1
fi
