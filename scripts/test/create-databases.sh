#!/bin/bash

# Check if FELIS_ENGINE_URL is set
if [ -z "$FELIS_ENGINE_URL" ]; then
    echo "Error: FELIS_ENGINE_URL is not set. Please set the environment variable and try again."
    exit 1
fi

# Initialize a variable to track if any command fails
error_occurred=0

# Create databases from YAML files, dropping existing databases since some
# names are duplicated across files.
for yaml_file in yml/*.yaml; do
    echo "Creating database from $yaml_file..."
    felis --log-level ERROR create --drop "$yaml_file"
    # Check if the felis command was successful
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create database from $yaml_file"
        error_occurred=1
    else
        echo "Done creating database from $yaml_file"
    fi
done

# Exit with non-zero status if any command failed
if [ $error_occurred -ne 0 ]; then
    exit 1
fi
