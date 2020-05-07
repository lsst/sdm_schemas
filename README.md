
Science Data Model Schemas
==========================

This repository stores schema definitions for user-facing data products (the
Science Data Model, or SDM). These schema definitions are YAML files that are
designed to be read with felis (https://github.com/lsst-dm/felis), which can
create derived schema formats from the YAML definitions (e.g., SQL CREATE TABLE
statements, or IVOA TAP_SCHEMA table contents.) These YAML schema definitions
serve as the "source of truth" for other downstream usage, including
verification of the catalog outputs from Rubin Observatory science pipelines.

The schemas in this repository serve several different purposes:

 * `yml/baselineSchema.yaml` describes the "goal" of the Rubin Observatory
   construction project; it is the column-for-column physical description that
   corresponds to the abstract schema specified by the Data Products Definition
   Document (LSE-163). __Changes to this schema require DM change-control board
   approval.__ `baselineSchema.yaml` is used to auto-generate the contents of
   LDM-153, which serves as the official reference for the baseline schema.
   When proposing changes to the baseline schema, updates may be made to
   `baselineSchema.yaml` via normal DM workflow and a new branch of LDM-153
   produced, which then requires approval by DM-CCB to become the new project
   baseline.

 * `yml/hsc.yaml` describes the outputs of the latest data release production
   pipelines. This schema is intended to approximate baselineSchema.yaml, but
   with the changes necessary to reflect the current state of the pipelines
   (e.g., columns that are not yet computed by the pipelines are removed, some
   names differ, and some additional useful columns are added). This schema is
   used by `ci_hsc`, which verifies that the schema of the pipeline output files
   agree with the contents of this file.

 * `yml/sdss_stripe82_01.yml` and `yml/wise_00.yml` describe tables that are
   served by the Rubin Observatory Science Platform, even though they are not
   produced by the observatory's science pipelines. These files are used to
   generate the TAP_SCHEMA records that are required for serving the catalogs
   via the IVOA Table Access Protocol (TAP).
 


