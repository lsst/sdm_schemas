Tools and Data Supporting IVOA Data Models
==========================================

The directory `sdm_schemas/yml/ivoa` contains data and software supporting the
generation of Felis YAML for representations of IVOA data models.

Initially this is limited to the ObsCore data model for observation metadata,
in its "ObsTAP" relational-database realization.
The Rubin Science Platform will provide ObsTAP, and eventually SIAv2,
observation-metadata services, and their output will be defined by a Felis
data model.

To support that work and ensure that standards-compliant schema (TAP_SCHEMA)
metadata are supplied by the RSP services for that data model, this directory
contains CSV files with the metadata supplied by the IVOA ObsCore v1.1 (as of
this writing) standard, with published errata applied, and with certain very
minor typographical errors corrected.

The Python script `make_obscore_nominal.py` uses that data, together with an
optional list of columns subsetting the full ObsCore data model, to emit Felis
YAML code defining that model.

It is anticipated that the resulting YAML may need further editing, to add
RSP-specific extensions, or to customize the description text in the model for
Rubin-specific, and pedagogical, purposes.
Therefore, at present, the script cannot be used to build a fully automated
toolchain for the creation of the final Felis for data served by the RSP.

CSV File Provenance
-------------------

* The file `ObsCore-v1.1-descriptions.csv` was derived from Table 5, "Data model
summary" in Appendix B of the
[ObsCore v1.1 standard](https://www.ivoa.net/documents/ObsCore/20170509/index.html).
Several corrections from the
[published 2nd erratum](https://wiki.ivoa.net/twiki/bin/view/IVOA/ObsCore-1_1-Erratum-2)
to the standard were applied, followed by purely typographical corrections to ensure
consistency of spacing and case.
The provenance of these edits has been maintained as separate commits
in the file history.
* The files `ObsCore-v1.1-mandatory.csv` and `ObsCore-v1.1-optional.csv` were
derived from Table 6, "TAP_SCHEMA.columns values for the mandatory fields of
an ObsTAP table", and Table 7, "... for the optional fields for an ObsTAP table.",
respectively, in Appendix C of the standard.
Note that these two tables have the same layout in the standard and the CSV files
accordingly have the same schema.
They have been cross-checked for consistency against `ObsCore-v1.1-descriptions.csv`,
but that file has a different schema, like its underlying table in the standard.
Corrections from the 
[published 1st erratum](https://wiki.ivoa.net/twiki/bin/view/IVOA/ObsCore-1_1-Erratum-1)
have been applied, as well as additional purely typographical corrections.
