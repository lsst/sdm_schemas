#!/bin/sh

# Postprocess script for felis Postgres SQL output for cdb_latiss (stdin)
echo "drop schema cdb_latiss cascade; create schema cdb_latiss;"
sed -e 's/"//g'
