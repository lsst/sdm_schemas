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

 * `yml/imsim.yaml` describes the outputs of the pipelines for LSSTCam-imSim.
   It is used to generate the data preview schemas, which are fixed at the time
   of their release, while this one will continue to evolve. This schema is
   used by `ci_imsim`, which verifies that the schema of the pipeline output
   files agree with the contents of this file.

 * The various `dp0X` schemas represent what is actively being served by the
   various data previews. These are created from `yml/imsim.yaml` at a
   specific point in time.

 * `yml/apdb.yaml` describes the schema used in the Alert Production Database (APDB).
  This schema reflects the current schema that is used for Alert Production with `ap_pipe`.
  It is also used in nightly `ap_verify` runs for continuous integration.
  Previous processing runs may differ from the current schema.
  The user-queryable Prompt Products Database (PPDB) is expected to have a very similar schema to the APDB.

 * `yml/hsc.yaml` describes the outputs of the latest data release production
   pipelines for HyperSuprimeCam. This schema is used by `ci_hsc`, which
   verifies that the schema of the pipeline output files agree with the
   contents of this file.

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
