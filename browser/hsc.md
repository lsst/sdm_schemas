---
layout: schema
title: HSC Schema
schema: hsc
sort-index: 20
---
The HSC Schema describes the outputs of the latest data release production pipelines for HyperSuprimeCam. This schema is intended
to approximate the LSST Baseline Schema, but with the changes necessary to reflect the current state of the
pipelines (e.g., columns that are not yet computed by the pipelines are removed, some names differ, and some
additional useful columns are added). This schema is used by [ci_hsc](https://github.com/lsst/ci_hsc), which
verifies the schema of the pipeline output files.
