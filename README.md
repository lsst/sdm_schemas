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

Release assets
--------------

Each release of `sdm_schemas` includes the following additional release
assets, generated automatically via GitHub Actions when a new tag is created.
   
 * `datalink-columns.zip` contains a set of YAML files with a restricted
   subset of the Felis schema. Currently, they identify the principal and
   minimal columns for a subset of the tables defined by the schema in
   this repository. Principal columns are those for which the `principal`
   flag is set in the TAP schema, and have the meaning defined in the
   [IVOA TAP
   specification](https://www.ivoa.net/documents/TAP/20190927/REC-TAP-1.1.html#tth_sEc4.3).
   Minimal columns are still experimental and in flux. These files are
   intended for use with the
   [datalinker](https://github.com/lsst-sqre/datalinker) service of a
   Rubin Science Platform depoyment.

 * `datalink-snippets.zip` contains a JSON manifest and a set of XML files
   that define VOTables following the IVOA DataLink specification. This
   release asset is intended for use with the TAP service of a Rubin
   Science Platform deployment and is used to add DataLink records to the
   responses from a TAP query. Those DataLink records, in turn, provide
   links to operations that a client may wish to perform on those results,
   such as closely-related TAP queries.
