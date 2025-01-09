Data Release Production Schemas
===============================

The Data Release Production (DRP) table schemas describe the `Object`, `Source`, `CcdVisit`, and `Visit` tables produced by either a regularly-tested "live" pipeline or a historical pipeline used in an important production.
In the future all data release tables (`ForcedSource`, `DIASource`, `DIAObject`, etc.) will be included as well.
When new major data release productions occur (e.g. a new Data Preview or Data Release), one of the live schemas is typically copied into a new file and adjusted to account for any differences specific to that production.

In particular:

- `hsc.yaml` maps to the live pipelines as configured for the Subaru Hypersuprime-Cam instrument and its Strategic Survey Program, one of the primary precursor datasets used for LSST development.
  The `ci_hsc_gen3` package (run nightly, as well as optionally prior to other pipeline code merges) in Jenkins tests that the schemas in this file match the Parquet datasets produced by the pipeline definition at [`drp_pipe/pipelines/HSC/DRP-ci_hsc.yaml`](https://github.com/lsst/drp_pipe/blob/main/pipelines/HSC/DRP-ci_hsc.yaml).
  The other HSC pipelines in `drp_pipe` should produce files with the same schemas as well, because they share almost all configuration with the `ci_hsc` pipeline.

- `imsim.yaml` similarly maps to the live pipelines as configured for the LSST ImSim simulator, in particular as run for the LSST Dark Energy Science Collaboration's "Data Challenge 2" project (DESC DC2).
  This is the same simulated dataset used for LSST's Data Preview 0.1 and 0.2, but the pipelines have evolved considerably since those productions.
  The `ci_imsim` package (run nightly, as well as optionally prior to other pipeline code merges) in Jenkins tests that the schemas in this file match the Parquet datasets produced by the pipeline definition at [`drp_pipe/pipelines/LSSTCam-imSim/DRP-ci_imsim.yaml`](https://github.com/lsst/drp_pipe/blob/main/pipelines/LSSTCam-imSim/DRP-ci_imsim.yaml).
  The other `LSSTCam-imSim` pipelines in `drp_pipe` should produce files with the same schemas as well, because they share almost all configuration with the `ci_imsim` pipeline.

These files must be updated whenever the final pipeline output tables change, but it is expected that these changes will usually be minor, since they are not formally change-controlled.
The intent is that change control bodies will instead be involved when these live schemas are copied for new productions that will be released to science users.
