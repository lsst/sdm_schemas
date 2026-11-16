---
myst:
  # Write the links on this page as they are, without checking them. This
  # allows the link to the schema browser, which Felis builds separately,
  # so Sphinx doesn't know about its pages.
  all_links_external: true
---

# Schema types

The schemas fall into the types below, each with its own way of naming its schemas.
The [schema browser](browser/index.html) lists every schema, and the schema files are in the [schemas directory](https://github.com/lsst/sdm_schemas/tree/main/python/lsst/sdm/schemas) on GitHub.

```{list-table}
:header-rows: 1
:widths: 20 50 30

* - Type
  - Description
  - Names
* - Data Previews and Releases
  - The catalogs of each Rubin data preview and data release, as served to users.
  - Start with `dp` for data previews or `dr` for data releases, such as `dp1`.
* - Science Pipelines
  - The catalogs produced by the Science Pipelines, which change as the pipelines are developed and are checked against the pipeline outputs in continuous integration.
  - Named after the instrument or simulation, such as `lsstcam`, `hsc` or `imsim`, with shared definitions in `drp_base`.
* - Solar System
  - Column definitions for the Solar System tables.
  - Start with `sso`, such as `sso_base`.
* - Alert Production and Prompt Products
  - The results of nightly alert production and prompt processing.
  - `apdb` and `ppdb`, and several other related schemas.
* - Consolidated Database
  - Information about each exposure and visit, from the observatory systems and data processing, with a schema for each instrument (`cdb`), and the Transformed EFD, which summarizes telemetry from the Engineering and Facilities Database (EFD) over each exposure and visit (`efd`).
  - Start with `cdb` for the Consolidated Database or `efd` for the Transformed EFD, followed by the instrument, such as `cdb_lsstcam`.
* - IVOA standards
  - Tables following standards of the [International Virtual Observatory Alliance (IVOA)](https://www.ivoa.net/).
  - Such as `ivoa_obscore` and `obsloctap`.
```

```{note}
A schema's file name is usually the same as the schema's name, but not always.
For example, the IVOA schemas in `ivoa_obscore.yaml` and `obsloctap.yaml` are both named `ivoa`, following the IVOA's standards.
```
