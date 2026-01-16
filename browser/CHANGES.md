---
layout: changes
title: Release Notes
---

Changes in [SDM Schemas](https://github.com/lsst/sdm_schemas) are generally organized by the type of schema which was affected:

**Data Releases** - Data Release and Data Preview schemas, having names that typically start with  `dp` or `dr` (e.g., `dp02_dc2`)

**Science Pipelines** - Schemas which are managed through continuous integration with the Science Pipelines (`imsim`, `hsc`)

**Alert Production** - Alert Production Database and Prompt Products Database used in nightly data processing (`apdb`)

**ConsDB** - Consolidated Database of Image Metadata schema, having names that start with `cdb` (e.g., `cdb_lsstcam`)

**Miscellaneous** - Catch-all category for changes which are not related to particular schemas, typically involving changes to GitHub workflows, project scripts, etc.

v30.0.0 (2026-01-16)
====================

Data Releases
-------------

- Add DP1 schema. ([DM-51047](https://jira.lsstcorp.org/browse/DM-51047))
- Corrected type of DiaSource.ssObjectReassocTime to match the true Postgres type in DP0.3;
  was causing run-time errors.  Corrected type of DiaSource.ccdVisitId as well, though this
  was a harmless inconsistency. ([DM-51064](https://jira.lsstcorp.org/browse/DM-51064))
- Renamed the 'dp02_v2.yaml' schema to 'dp01.yaml' and reformatted it using the `felis dump` command. ([DM-51408](https://jira.lsstcorp.org/browse/DM-51408))
- Removed the '@id' fields from the dp1.yaml schema for DP1.
  These should not longer be needed after recent updates to Felis. ([DM-51410](https://jira.lsstcorp.org/browse/DM-51410))
- Changed 'fits:tunit' values to 'ivoa:unit' in DP1 schema ([DM-51411](https://jira.lsstcorp.org/browse/DM-51411))
- Assigned an order to the DP1 tables, derived from the DP0.2 order. ([DM-51414](https://jira.lsstcorp.org/browse/DM-51414))
- Added foreign key relationships to DP1 schema.
  These do not include the "visit+detector" relationships. ([DM-51415](https://jira.lsstcorp.org/browse/DM-51415))
- Propagated DP0.2 table service descriptors to DP1 ([DM-51416](https://jira.lsstcorp.org/browse/DM-51416))
- Revise descriptions for Object columns, add principal tags ([DM-51417](https://jira.lsstcorp.org/browse/DM-51417))
- Added DP1 virtual columns. ([DM-51449](https://jira.lsstcorp.org/browse/DM-51449))
- Added DP0.2 ObsCore table to main DP0.2 schema ([DM-51478](https://jira.lsstcorp.org/browse/DM-51478))
- Removed arraysize overrides from DP1 ObsCore table ([DM-51506](https://jira.lsstcorp.org/browse/DM-51506))
- Added DP1 static ObsCore table; configured only for data-int ([DM-51507](https://jira.lsstcorp.org/browse/DM-51507))
- Add the DP1 and IVOA ObsCore schemas to the `idfprod` environment (data.lsst.cloud) ([DM-51511](https://jira.lsstcorp.org/browse/DM-51511))
- Updated DP1 schema and table descriptions for release. ([DM-51541](https://jira.lsstcorp.org/browse/DM-51541))
- Removed DP1 static ObsCore table from `dp1` schema (it is only in the `ivoa.ObsCore` table in Qserv now) ([DM-51545](https://jira.lsstcorp.org/browse/DM-51545))
- Added obs_title to DP1 ObsCore ([DM-51549](https://jira.lsstcorp.org/browse/DM-51549))
- Removed `decl` columns from DP1 that had long since been declared deprecated. ([DM-51559](https://jira.lsstcorp.org/browse/DM-51559))
- Added `CoaddPatches` table ([DM-51560](https://jira.lsstcorp.org/browse/DM-51560))
- Added index definitions to the DP1 schema ([DM-51573](https://jira.lsstcorp.org/browse/DM-51573))
- Copied `tap:principal` column metadata from DP0.2 to DP1 non-Object tables.
  Tables included ForcedSource, ForcedSourceOnDiaObject, Visit, and CcdVisit.
  A few additional principal columns were added for columns not present in DP0.2. ([DM-51600](https://jira.lsstcorp.org/browse/DM-51600))
- Revised foreign-key descriptions to clarify 1:N relationships. ([DM-51604](https://jira.lsstcorp.org/browse/DM-51604))


Science Pipelines
-----------------

- Added starEMedian and starUnNormalizedEMedian to lsstcam.yaml, hsc.yaml, and imsim.yaml. ([DM-48316](https://jira.lsstcorp.org/browse/DM-48316))
- Changed `double` columns to `float`. ([DM-49074](https://jira.lsstcorp.org/browse/DM-49074))
- Separated `NO_DATA` from `EDGE` pixel flag in HSC schema. ([DM-49274](https://jira.lsstcorp.org/browse/DM-49274))
- Added sky-coordinate moments. ([DM-49710](https://jira.lsstcorp.org/browse/DM-49710))
- Add trailFluxErr column to `diaSource` table in imsim.yaml. ([DM-49714](https://jira.lsstcorp.org/browse/DM-49714))
- Added epoch columns to `Object` table. ([DM-49727](https://jira.lsstcorp.org/browse/DM-49727))
- Propagated `noData` flags into `ForcedSource` tables. ([DM-49729](https://jira.lsstcorp.org/browse/DM-49729))
- Upgrade mysql to version 8.0.41 for TAP_SCHEMA database ([DM-49876](https://jira.lsstcorp.org/browse/DM-49876))
- Change id to column_id in tap_schema columns and Add api_created column to the tap_schema tables table ([DM-50252](https://jira.lsstcorp.org/browse/DM-50252))
- Extensive changes to the AP DIAObject and DIASource schemas to remove unpopulated fields. ([DM-50837](https://jira.lsstcorp.org/browse/DM-50837))
- Added glint_trail boolean flag column to the imsim schema.
  This new column will now appear in all DiaSource tables. ([DM-50988](https://jira.lsstcorp.org/browse/DM-50988))
- Added templateFlux and templateFluxErr to imsim.yaml. ([DM-51823](https://jira.lsstcorp.org/browse/DM-51823))
- Convert DIA timestamp fields to MJD TAI and rename them.

  This changes `DiaSource.time_processed` `timeProcessedMjdTai`. ([DM-52215](https://jira.lsstcorp.org/browse/DM-52215))
- Add MultiProFit exponential model fit columns to object table ([DM-52462](https://jira.lsstcorp.org/browse/DM-52462))
- Add model_extendedness columns

  These columns are a new, continuous classification for whether an object is
  compact or extended. There is one column per band and one with griz combined. ([DM-52667](https://jira.lsstcorp.org/browse/DM-52667))
- Removed and renamed columns in the Object table per RFC-1131.
  - Removed GAAP fluxes with apertures >= 1.5 and Optimal
  - Removed reference centroids (x, y) in pixel coords.
  - Renamed reference centroid flag from xy_flag to coord_flag
    and move under coord_ra/coord_dec
  - Removed per-band centroids in pixel coords
  - Removed calib fluxes
  - Removed ixyRound et al. ([DM-52922](https://jira.lsstcorp.org/browse/DM-52922))
- Added default schema for the LSSTCam DRP pipeline.
  Removed forcedSourceId and forcedSourceOnDiaObjectId from respective schemas. ([DM-53027](https://jira.lsstcorp.org/browse/DM-53027))
- Updates to Solar System related tables (RFC-1138)

  Major update to Solar System table schemas as described in RFC-1138. The
  tables affected are SSObject, SSSource, mpc_orbits, current_identifications
  and numbered_identifications. mpc_orbits now replaces the MPCORB table. ([DM-53310](https://jira.lsstcorp.org/browse/DM-53310))
- Add view_target column to TAP_SCHEMA tables table ([DM-53338](https://jira.lsstcorp.org/browse/DM-53338))
- Add major/minor/position angle galaxy model ellipse columns

  This implements parts of RFC-1081 and most of RFC-1132. ([DM-53442](https://jira.lsstcorp.org/browse/DM-53442))


Alert Production
----------------

- Added starEMedian and starUnNormalizedEMedian to apdb.yaml. ([DM-48316](https://jira.lsstcorp.org/browse/DM-48316))
- Extensive changes to the AP DIAObject and DIASource schemas to remove unpopulated fields. ([DM-50837](https://jira.lsstcorp.org/browse/DM-50837))
- Added glint_trail boolean flag column to the apdb schema.
  This new column will now appear in all DiaSource tables. ([DM-50988](https://jira.lsstcorp.org/browse/DM-50988))
- To match DP1, removed all MPCORB columns except ssObjectId, mpcH, epoch, a, e, incl, node, peri, M.
  Added q, t_p to include cometary elements. ([DM-51864](https://jira.lsstcorp.org/browse/DM-51864))
- Corrected SSSource velocity units from AU to AU/d ([DM-51993](https://jira.lsstcorp.org/browse/DM-51993))
- Convert DIA timestamp fields to MJD TAI and rename them.

  This changes `DiaSource` and `DiaForcedSource.time_processed` and `time_withdrawn` to `timeProcessedMjdTai` and `timeWithdrawnMjdTai`.
  `DiaSource.ssObjectReassocTime` becomes `ssObjectReassocTimeMjdTai`.
  Similarly, `DIAObject.validityStart` and `validityEnd` become `validityStartMjdTai` and `validityEndMjdTai`. ([DM-52215](https://jira.lsstcorp.org/browse/DM-52215))
- `DiaObjectLast` adds a new column `validityStartMjdTai` which represents the start of the latest validity interval for a `diaObjectId`. ([DM-52827](https://jira.lsstcorp.org/browse/DM-52827))
- Updates to Solar System related tables (RFC-1138)

  Major update to Solar System table schemas as described in RFC-1138.  The
  tables affected are SSObject, SSSource, mpc_orbits, current_identifications
  and numbered_identifications.  mpc_orbits replaces the MPCORB table, and
  current_identifications replaces the MPCDESIGMAP tables. ([DM-53310](https://jira.lsstcorp.org/browse/DM-53310))


Consolidated Database
---------------------

- Added the Transformed EFD schemas. ([DM-43722](https://jira.lsstcorp.org/browse/DM-43722))
- Added scheduler_note column to the cdb schemas. ([DM-47965](https://jira.lsstcorp.org/browse/DM-47965))
- Added can_see_sky column to the cdb schemas. ([DM-51051](https://jira.lsstcorp.org/browse/DM-51051))
- Added zernikes column to the cdb ccdvisit1_quicklook and visit1_quicklook schema. ([DM-51220](https://jira.lsstcorp.org/browse/DM-51220))
- New primary key columns were added to the Transformed EFD schemas, modifying the basic structure. New columns were added per request. IVOA metadata was added and/or updated. ([DM-51362](https://jira.lsstcorp.org/browse/DM-51362))
- Added tap:table_index values for ConsDB schemas.
  Exposure and related tables come first (100 series), followed by visit tables (200 series).
  Per-CCD versions of the above follow (300 and 400 series).
  Last are the flexible metadata schemas that are currently unused (and may not ever become public, if they are used; 800 and 900 series). ([DM-51439](https://jira.lsstcorp.org/browse/DM-51439))
- Added aos_fwhm, donut_blur_fwhm and physical_rotator_angle to exposure consdb table.
  Added m1m3 glycol temperatures, salindex 112 temperature sensors, fan coil unit temperatures, m2 ring temperatures and compensation offsets to transformed_efd consdb. ([DM-51455](https://jira.lsstcorp.org/browse/DM-51455))
- Added jitter and image degradation columns for the exposure_quicklook table. ([DM-51764](https://jira.lsstcorp.org/browse/DM-51764))
- Added guider columns to visit1_quicklook table. ([DM-52666](https://jira.lsstcorp.org/browse/DM-52666))
- Added even more guider columns to visit1_quicklook table. ([OSW-1516](https://jira.lsstcorp.org/browse/OSW-1516))


Miscellaneous
-------------

- Remove dependence on the `@id` field from the schema browser.
  Felis was changed to generate IDs by default, so these may not be present in the YAML files. ([DM-46240](https://jira.lsstcorp.org/browse/DM-46240))
- Moved schema descriptions from browser markdown into YAML files.
  No custom schema descriptions should be present anymore in the schema browser. ([DM-46896](https://jira.lsstcorp.org/browse/DM-46896))
- Sort tables by their 'tap:table_index' in the schema browser.
  Tables without this field are listed alphabetically after those which do. ([DM-46989](https://jira.lsstcorp.org/browse/DM-46989))
- Added index details section to each table in the schema browser ([DM-48366](https://jira.lsstcorp.org/browse/DM-48366))
- Removed the dependency on the `sdm_tools` repository.
  This is an unwanted extra dependency for projects which will eventually depend on `sdm_schemas`.
  The GitHub workflows were updated to install this dependency using `pip` instead. ([DM-49962](https://jira.lsstcorp.org/browse/DM-49962))
- Added `cdb_lsstcam` to the schema browser. ([DM-50521](https://jira.lsstcorp.org/browse/DM-50521))
- Added ``--force-unbounded-arraysize`` to ``tap-schema/build`` for forcing VOTable arraysize to '*' on columns by default for variable length string types.
  This change affects the arraysize values in the TAP_SCHEMA SQL output that is generated for the Docker images.
  This is a temporary workaround for [astropy Issue #18099](https://github.com/astropy/astropy/issues/18099), which will eventually be reverted once there is a permanent fix. ([DM-50914](https://jira.lsstcorp.org/browse/DM-50914))
- Added the IVOA ObsCore schema ('ivoa_obscore.yaml') to the schema browser ([DM-51557](https://jira.lsstcorp.org/browse/DM-51557))
- Build for both linux/amd64 and linux/arm64.
  Add schemas for `idfdemo` environment. ([DM-52731](https://jira.lsstcorp.org/browse/DM-52731))

v29.0.0 (2025-03-31)
====================

<!--
Added changes by hand from:
git log v28.0.0.rc1..v29.0.0.rc1 --merges --pretty=format:"%h %s"
-->

Data Releases
-------------

- Ensured (tract, patch) are always displayed, visually, in that order in DP catalogs. ([DM-43996](https://jira.lsstcorp.org/browse/DM-43996))

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

Data Releases
-------------

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
- Removed DP0.1 from TAP_SCHEMA on IDF `int` and `dev`. ([DM-44884](https://jira.lsstcorp.org/browse/DM-44884))
- Added database tests to GitHub workflows. ([DM-44158](https://jira.lsstcorp.org/browse/DM-44158))
- Updated the schema browser to use LTD. ([DM-41310](https://jira.lsstcorp.org/browse/DM-41310))
