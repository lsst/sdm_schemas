---
layout: changes
title: Release Notes
---

v29.0.0 (2025-03-31)
====================

<!--
Added changes by hand from:
git log v28.0.0.rc1..v29.0.0.rc1 --merges --pretty=format:"%h %s"
-->

Data Release
------------

- Ensure (tract, patch) are always displayed, visually, in that order in DP catalogs. ([DM-43996](https://jira.lsstcorp.org/browse/DM-43996))

Science Pipelines
-----------------

- Updated description of `extendedness` column. ([DM-46681](https://jira.lsstcorp.org/browse/DM-46681))
- Added `dipoleFitAttempted` flag. ([DM-48106](https://jira.lsstcorp.org/browse/DM-48106))
- Separated `EDGE` and `NO_DATA` pixel flags. ([DM-45621](https://jira.lsstcorp.org/browse/DM-45621))
- Removed STREAK mask columns. ([DM-46933](https://jira.lsstcorp.org/browse/DM-46933))
- Removed `calib_detected` column from `Source` table. ([DM-46991](https://jira.lsstcorp.org/browse/DM-46991))
- Removed `localWcs` and `localPhotoCalib` columns from ImSim `Sources` table. ([DM-48117](https://jira.lsstcorp.org/browse/DM-48117))
- Added contributor documentation for DRP schemas. ([DM-48178](https://jira.lsstcorp.org/browse/DM-48178))
- Added multiprofit two-Gaussian PSF and Sersic columns. ([DM-48591](https://jira.lsstcorp.org/browse/DM-48591))

Alert Production
----------------

- Updated description of `extendedness` column. ([DM-46681](https://jira.lsstcorp.org/browse/DM-46681))
- Added `dipoleFitAttempted` flag. ([DM-48106](https://jira.lsstcorp.org/browse/DM-48106))
- Separated `EDGE` and `NO_DATA` pixel flags. ([DM-45621](https://jira.lsstcorp.org/browse/DM-45621))
- Added `nDiaSources` column to `DiaObjectLast` table. ([DM-44098](https://jira.lsstcorp.org/browse/DM-44098))
- Added column with `is_negative` flag. ([DM-48437](https://jira.lsstcorp.org/browse/DM-48437))

Consolidated Database
---------------------

- Added several missing ConsDB schemas to the schema browser. ([DM-46895](https://jira.lsstcorp.org/browse/DM-46895))
- Added `pixelScale` and PSF model delta metric columns. ([DM-47002](https://jira.lsstcorp.org/browse/DM-47002))
- Updated units in `cdb_lsstcomcam`.`visit1_quicklook`. ([DM-47044](https://jira.lsstcorp.org/browse/DM-47044))
- Added electron UCDs in `cdb_lsstcomcam`. ([DM-47308](https://jira.lsstcorp.org/browse/DM-47308))
- Moved mount and jitter columns to `exposure_quicklook` table. ([DM-47443](https://jira.lsstcorp.org/browse/DM-47443))

Miscellaneous
-------------

- Added Python packaging with support for resource paths. ([DM-46273](https://jira.lsstcorp.org/browse/DM-46273))
- Improved the schema browser. ([DM-41867](https://jira.lsstcorp.org/browse/DM-41867))
- Added toggle for table pagination in the schema browser. ([DM-46982](https://jira.lsstcorp.org/browse/DM-46982))
- Add EUPS and SCons configuration for resource path support. ([DM-47069](https://jira.lsstcorp.org/browse/DM-47069))
- Moved YAML files into Python source tree. ([DM-47147](https://jira.lsstcorp.org/browse/DM-47147))
- Fixed problems with GitHub build workflow. ([DM-47403](https://jira.lsstcorp.org/browse/DM-47403))
- Added workflow to perform schema comparisons and check for changes to deployed schemas. ([DM-46158](https://jira.lsstcorp.org/browse/DM-46158))
- Added GitHub workflow that runs extra validation checks. ([DM-47844](https://jira.lsstcorp.org/browse/DM-47844))
- Added contribution guide and pull request template. ([DM-48013](https://jira.lsstcorp.org/browse/DM-48013))
- Changed the TAP_SCHEMA build to use the new Felis command `load-tap-schema`. ([DM-46957](https://jira.lsstcorp.org/browse/DM-46957))
- Added `api_created` field to `tap_schema.schemas` table definition. ([DM-48979](https://jira.lsstcorp.org/browse/DM-48979))
- Added the [sdm_tools](https://github.com/lsst/sdm_tools) dependency, which provides a new command line utility
  for processing schema files. Ported the script for generating the Datalink snippets to the new repository.
  ([DM-41290](https://jira.lsstcorp.org/browse/DM-41290))
- Added support for towncrier. ([DM-49711](https://jira.lsstcorp.org/browse/DM-49711))

v28.0.0 (2025-01-23)
====================

<!--
Added changes by hand from:
git log 27.0.0..28.0.0 --merges --pretty=format:"%h %s"
-->

Data Release
------------

- Added missing primary keys to DP0.2. ([DM-43115](https://jira.lsstcorp.org/browse/DM-43115))
- Removed DP0.1 from TAP_SCHEMA and DataLink builds. ([DM-44884](https://jira.lsstcorp.org/browse/DM-44884))
- Fixed lengths and datatypes of string columns. ([DM-43946](https://jira.lsstcorp.org/browse/DM-43946))
- Added missing precision values on timestamps. ([DM-44825](https://jira.lsstcorp.org/browse/DM-44825))
- Removed datatype overrides on timestamp columns and specified precision. ([DM-44825](https://jira.lsstcorp.org/browse/DM-44825))
- Removed length fields and type overrides from timestamp columns. ([DM-44059](https://jira.lsstcorp.org/browse/DM-44059))
- Removed unused `mysql:datatype` overrides on string columns. ([DM-44637](https://jira.lsstcorp.org/browse/DM-44637))
- Removed unused `mysql:datatype` overrides on numeric columns. ([DM-44241](https://jira.lsstcorp.org/browse/DM-44241))
- Removed redundant `mysql:datatype` overrides for Felis numeric types. ([DM-43716](https://jira.lsstcorp.org/browse/DM-43716))
- Removed redundant `mysql:datatype` overrides for Felis boolean types. ([DM-43958](https://jira.lsstcorp.org/browse/DM-43958))
- Removed redundant `mysql:datatype` overrides for Felis fixed length strings. ([DM-43956](https://jira.lsstcorp.org/browse/DM-43956))

Science Pipelines
-----------------

- Fixed lengths and datatypes of string columns. ([DM-43946](https://jira.lsstcorp.org/browse/DM-43946))
- Migrated from `ccdVisitId` to `(visit, detectors)`. ([DM-42435](https://jira.lsstcorp.org/browse/DM-42435))
- Added `invalidPsfFlag` column. ([DM-44167](https://jira.lsstcorp.org/browse/DM-44167))
- Removed datatype overrides on timestamp columns and specified precision. ([DM-44825](https://jira.lsstcorp.org/browse/DM-44825))
- Removed length fields and type overrides from timestamp columns. ([DM-44059](https://jira.lsstcorp.org/browse/DM-44059))
- Added `pixelScale` to `visitSummary` and `ccdVisit` tables. ([DM-44854](https://jira.lsstcorp.org/browse/DM-44854))
- Added `psfApCorrDelta` and `psfApFluxDelta` metrics to exposure summaries. ([DM-37952](https://jira.lsstcorp.org/browse/DM-37952))
- Removed unused `mysql:datatype` overrides on numeric columns. ([DM-44241](https://jira.lsstcorp.org/browse/DM-44241))
- Added normalized, compensated tophat fluxes to `Source` tables. ([DM-38632](https://jira.lsstcorp.org/browse/DM-38632))
- Removed redundant `mysql:datatype` overrides for Felis numeric types. ([DM-43716](https://jira.lsstcorp.org/browse/DM-43716))
- Removed redundant `mysql:datatype` overrides for Felis boolean types. ([DM-43958](https://jira.lsstcorp.org/browse/DM-43958))
- Removed redundant `mysql:datatype` overrides for Felis fixed length strings. ([DM-43956](https://jira.lsstcorp.org/browse/DM-43956))

Alert Production
----------------

- Corrected column `value` fields to use correct type, so `0` instead of `"0"`. ([DM-46073](https://jira.lsstcorp.org/browse/DM-43998))
- Migrated from `ccdVisitId` to `(visit, detectors)`. ([DM-42435](https://jira.lsstcorp.org/browse/DM-42435))
- Added individual flag fields. ([DM-41530](https://jira.lsstcorp.org/browse/DM-41530))
- Removed placeholder time series feature columns from `DiaObject` table. ([DM-44092](https://jira.lsstcorp.org/browse/DM-44092))
- Removed length fields and type overrides from timestamp columns. ([DM-44059](https://jira.lsstcorp.org/browse/DM-44059))
- Added `ra` and `dec` and removed `x` and `y` from `DiaForcedSource`. ([DM-44470](https://jira.lsstcorp.org/browse/DM-44470))
- Added `psfApCorrDelta` and `psfApFluxDelta` metrics to exposure summaries. ([DM-37952](https://jira.lsstcorp.org/browse/DM-37952))
- Removed unused `mysql:datatype` overrides on numeric columns. ([DM-44241](https://jira.lsstcorp.org/browse/DM-44241))
- Removed redundant `mysql:datatype` overrides for Felis numeric types. ([DM-43716](https://jira.lsstcorp.org/browse/DM-43716))
- Removed redundant `mysql:datatype` overrides for Felis fixed length strings. ([DM-43956](https://jira.lsstcorp.org/browse/DM-43956))

Consolidated Database
---------------------

- Implemented multi-column primary key wth `day_obs` and `seq_num`. ([DM-46073](https://jira.lsstcorp.org/browse/DM-46628))
- Added `exposure_quicklook` table to LATISS and ComCam. ([DM-46628](https://jira.lsstcorp.org/browse/DM-46628))
- Added StarTracker schemas. ([DM-45893](https://jira.lsstcorp.org/browse/DM-45893))
- Added mount jitter to LATISS and ComCam. ([DM-46009](https://jira.lsstcorp.org/browse/DM-46009))
- Added magnitude limit columns from exposure summary stats. ([DM-45573](https://jira.lsstcorp.org/browse/DM-45573))
- Added `postisr_pixel_median` columns. ([DM-45848](https://jira.lsstcorp.org/browse/DM-45848))
- Made constraint names unique. ([DM-45623](https://jira.lsstcorp.org/browse/DM-45623))
- Removed datatype overrides on timestamp columns and specified precision. ([DM-44825](https://jira.lsstcorp.org/browse/DM-44825))
- Added `vignette` columns. ([DM-44967](https://jira.lsstcorp.org/browse/DM-44967))
- Updated descriptions for `eff_time_*_scale` columns. ([DM-44958](https://jira.lsstcorp.org/browse/DM-44958))
- Updated descriptions for `eff_time` metric columns. ([DM-44955](https://jira.lsstcorp.org/browse/DM-44955))
- Added a representative ConsDB schema. ([DM-44161](https://jira.lsstcorp.org/browse/DM-44161))
- Added `CcdExposure` tables and LSSTComCamSim schema. ([DM-44429](https://jira.lsstcorp.org/browse/DM-44429))
- Added `visit1` and `ccdvisit1` tables. ([DM-44489](https://jira.lsstcorp.org/browse/DM-44489))

Miscellaneous
-------------

- Changed the TAP_SCHEMA workflow to set the schema index with a command line argument to Felis.
  ([DM-42935](https://jira.lsstcorp.org/browse/DM-42935))
- Added redundant datatype checks to validation workflow. ([DM-44058](https://jira.lsstcorp.org/browse/DM-44058))
- Deleted UWS creation script from `tap-schema/sql` directory. ([DM-45099](https://jira.lsstcorp.org/browse/DM-45099))
- Removed DP0.1 from TAP_SCHEMA on IDF `int` and `dev`. (ÄDM-44884Å(https://jira.lsstcorp.org/browse/DM-44884))
- Added database tests to GitHub workflows. ([DM-44158](https://jira.lsstcorp.org/browse/DM-44158))
- Updated the schema browser to use LTD. ([DM-41310](https://jira.lsstcorp.org/browse/DM-41310))
