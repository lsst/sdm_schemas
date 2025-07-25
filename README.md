Science Data Model Schemas
==========================

This repository stores schema definitions for user-facing data
products comprising the Science Data Model (SDM) of the
[Rubin Observatory](https://rubinobservatory.org/).
These schemas are defined in YAML files designed to be read with
[Felis](https://github.com/lsst/felis), a tool which can convert this data
to derived formats including SQL DDL and
[TAP_SCHEMA](https://www.ivoa.net/documents/TAP/20180830/PR-TAP-1.1-20180830.html#tth_sEc4).
These schema definitions serve as the "source of truth" for the observatory's core data models.

Schemas
-------

The following schemas are maintained in this repository under the [schemas](./python/lsst/sdm/schemas) directory:

 * [imsim](./python/lsst/sdm/schemas/imsim.yaml) describes the outputs
   of the pipelines for LSSTCam-imSim, used to generate the data preview
   schemas, which are fixed at the time of their release, while `imsim` will
   continue to evolve. This schema is used by
   [ci_imsim](https://github.com/lsst/ci_imsim) to verify that the tabular data
   of the pipeline output files is conformant with the schema definition.

 * The various Data Preview (DP) schemas such as
   [dp02_dc2](./python/lsst/sdm/schemas/dp02_dc2.yaml) represent
   content that is being actively served by the various data previews.
   These are created from `imsim` at a specific point in time.

 * [apdb](./python/lsst/sdm/schemas/apdb.yaml) describes the schema
   of the Alert Production Database (APDB) used for Alert Production with
   `ap_pipe` and for nightly `ap_verify` runs within continuous integration.
   Previous processing runs may differ from the current schema. The
   user-queryable Prompt Products Database (PPDB) is expected to have a very similar schema to the APDB.

 * [hsc](./python/lsst/sdm/schemas/hsc.yaml) describes the outputs of
   the latest data release production pipelines for HyperSuprimeCam. This
   schema is used by [ci_hsc](https://github.com/lsst/ci_hsc) for verification
   of its output files.

* The various `cdb` schemas such as
  [cdb_latiss](./python/lsst/sdm/schemas/cdb_latiss.yaml) describe the
  data model of the [Consolidated Database](https://github.com/lsst-dm/consdb)
  or ConsDB, an image metadata database containing summarizations of
  Engineering Facilities Database (EFD) telemetry by exposure and visit time windows.

* The various `efd` schemas such as
  [efd_latiss](./python/lsst/sdm/schemas/efd_latiss.yaml) describe the
  data model of the Transformed EFD at the [Consolidated Database](https://github.com/lsst-dm/consdb)
  or ConsDB, which consists of telemetry transformed over time spans defined by the 
  duration of the exposures and visits.

Release Assets
--------------

Each release of `sdm_schemas` includes the following additional assets,
generated automatically via GitHub Actions when a new tag is created:

 * `datalink-columns.zip` contains a set of YAML files with a restricted
   subset of the Felis schema. Currently, these identify the principal and
   minimal columns for a subset of the tables defined by the schema in
   this repository. Principal columns are those for which the `principal`
   flag is set in the TAP schema, defined in the
   [IVOA TAP
   specification](https://www.ivoa.net/documents/TAP/20190927/REC-TAP-1.1.html#tth_sEc4.3).
   The minimal columns are still experimental and in flux. These files are
   intended for use with the
   [datalinker](https://github.com/lsst-sqre/datalinker) service of a
   Rubin Science Platform deployment.

 * `datalink-snippets.zip` contains a JSON manifest and a set of XML files
   that define VOTables following the IVOA DataLink specification and are
   intended to be used by the TAP service of a Rubin Science Platform
   deployment for adding DataLink records to the responses from a TAP query.
   Those DataLink records, in turn, provide links to operations that a client
   may wish to perform on those results, such as closely-related TAP queries.
