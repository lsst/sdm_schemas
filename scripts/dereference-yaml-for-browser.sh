#!/bin/bash

set -euo pipefail

mkdir -p browser/yml
for schema in yml/*.yaml; do
    base=$(basename "$schema")
    felis --log-level ERROR --column-ref-index-increment 10 dump \
        "$schema" "browser/yml/$base" \
        --dereference-resources --strip-ids
done
