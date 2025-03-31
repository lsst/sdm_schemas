---
layout: changes
title: Release Notes
---

v29.0.0 (2025-03-31)
====================

<!--
Added changes by hand based on:
git log v28.0.0.rc1..v29.0.0.rc1 --merges --pretty=format:"%h %s"
-->

Data Release
------------

- Ensure (tract, patch) are always displayed, visually, in that order in DP catalogs. ([DM-43996](https://jira.lsstcorp.org/browse/DM-43996))

Science Pipelines
-----------------

- Added multiprofit two-Gaussian PSF and Sersic columns. ([DM-48591](https://jira.lsstcorp.org/browse/DM-48591))
- Added contributor documentation for DRP schemas.
  ([DM-48178](https://jira.lsstcorp.org/browse/DM-48178))
- Removed `localWcs` and `localPhotoCalib` columns from ImSim `Sources` table. ([DM-48117](https://jira.lsstcorp.org/browse/DM-48117))
- Removed `calib_detected` column from `Source` table. ([DM-46991](https://jira.lsstcorp.org/browse/DM-46991))
- Removed STREAK mask columns. ([DM-46933](https://jira.lsstcorp.org/browse/DM-46933))
- Separated `EDGE` and `NO_DATA` pixel flags. ([DM-45621](https://jira.lsstcorp.org/browse/DM-45621))
- Added `dipoleFitAttempted` flag. ([DM-48106](https://jira.lsstcorp.org/browse/DM-48106))
- Updated description of `extendedness` column. ([DM-46681](https://jira.lsstcorp.org/browse/DM-46681))

Alert Production
----------------

- Added column with `is_negative` flag. ([DM-48437](https://jira.lsstcorp.org/browse/DM-48437))
- Added `nDiaSources` column to `DiaObjectLast` table. ([DM-44098](https://jira.lsstcorp.org/browse/DM-44098))
- Separated `EDGE` and `NO_DATA` pixel flags. ([DM-45621](https://jira.lsstcorp.org/browse/DM-45621))
- Added `dipoleFitAttempted` flag. ([DM-48106](https://jira.lsstcorp.org/browse/DM-48106))
- Updated description of `extendedness` column. ([DM-46681](https://jira.lsstcorp.org/browse/DM-46681))

Consolidated Database
---------------------

- Moved mount and jitter columns to `exposure_quicklook` table. ([DM-47443](https://jira.lsstcorp.org/browse/DM-47443))
- Added electron UCDs in `cdb_lsstcomcam`. ([DM-47308](https://jira.lsstcorp.org/browse/DM-47308))
- Updated units in `cdb_lsstcomcam`.`visit1_quicklook`. ([DM-47044](https://jira.lsstcorp.org/browse/DM-47044))
- Added `pixelScale` and PSF model delta metric columns. ([DM-47002](https://jira.lsstcorp.org/browse/DM-47002))
- Added several missing ConsDB schemas to the schema browser. ([DM-46895](https://jira.lsstcorp.org/browse/DM-46895))

Miscellaneous
-------------

- Added support for towncrier. ([DM-49711](https://jira.lsstcorp.org/browse/DM-49711))
- Added the [sdm_tools](https://github.com/lsst/sdm_tools) dependency, which provides a new command line utility
  for processing schema files. Ported the script for generating the Datalink snippets to the new repository.
  ([DM-41290](https://jira.lsstcorp.org/browse/DM-41290))
- Added `api_created` field to `tap_schema.schemas` table definition. ([DM-48979](https://jira.lsstcorp.org/browse/DM-48979))
- Changed the TAP_SCHEMA build to use the new Felis command `load-tap-schema`. ([DM-46957](https://jira.lsstcorp.org/browse/DM-46957))
- Added contribution guide and pull request template. ([DM-48013](https://jira.lsstcorp.org/browse/DM-48013))
- Added GitHub workflow that runs extra validation checks. ([DM-47844](https://jira.lsstcorp.org/browse/DM-47844))
- Added workflow to perform schema comparisons and check for changes to deployed schemas. ([DM-46158](https://jira.lsstcorp.org/browse/DM-46158))
- Fixed problems with GitHub build workflow. ([DM-47403](https://jira.lsstcorp.org/browse/DM-47403))
- Moved YAML files into Python source tree. ([DM-47147](https://jira.lsstcorp.org/browse/DM-47147))
- Add EUPS and SCons configuration for resource path support. ([DM-47069](https://jira.lsstcorp.org/browse/DM-47069))
- Added toggle for table pagination in the schema browser. ([DM-46982](https://jira.lsstcorp.org/browse/DM-46982))
- Improved the schema browser. ([DM-41867](https://jira.lsstcorp.org/browse/DM-41867))
- Added Python packaging with support for resource paths. ([DM-46273](https://jira.lsstcorp.org/browse/DM-46273))
