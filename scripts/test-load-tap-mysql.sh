#!/bin/bash

# Check if FELIS_ENGINE_URL is set
if [ -z "$FELIS_ENGINE_URL" ]; then
    echo "Error: FELIS_ENGINE_URL is not set. Please set the environment variable and try again."
    exit 1
fi

# Initialize a variable to track if any command fails
error_occurred=0

for yaml_file in yml/*.yaml; do
    filename=$(basename "$yaml_file")
    echo "Uploading to TAP_SCHEMA from $yaml_file..."
    felis --log-level ERROR load-tap --engine-url ${FELIS_ENGINE_URL}/TAP_SCHEMA "$yaml_file"
    # Check if the felis command was successful
    if [ $? -ne 0 ]; then
      echo "Error: Failed to create SQL from $file"
      error_occurred=1
    else
      echo "Done creating SQL from $yaml_file"
    fi
    mysql -DTAP_SCHEMA -e "
        DELETE FROM \`columns\`;
        DELETE FROM \`key_columns\`;
        DELETE FROM \`keys\`;
        DELETE FROM \`schemas\`;
        DELETE FROM \`tables\`;
    "
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    echo "Error: Failed to load all schemas into TAP_SCHEMA"
    exit 1
fi
