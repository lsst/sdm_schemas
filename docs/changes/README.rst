Recording Changes
=================

This directory contains "news fragments" which are small files containing text that will be integrated into release notes.
The files can be in restructured text format or plain text.

Each file should be named like ``<JIRA TICKET>.<TYPE>`` with a file extension defining the markup format.
The ``<TYPE>`` corresponds to a particular schema category and should be one of:

* ``dr``: Data Release (DR), including Data Preview (DP)
* ``ci``: Data Release Processing (DRP) schemas managed by pipelines CI (e.g., ImSim and HSC)
* ``ap``: Alert Production Database (APDB) and Prompt Products Database (PPDB)
* ``cdb``: Consolidated Database of Image Metadata (ConsDB)

For non-schema-related changes, this type should be used:

* ``misc``: Miscellaneous Changes (no schema updates)

An example file name would therefore look like ``DM-12345.misc.rst`` or ``DM-67890.ci.md``.

You can test how the content will be integrated into the release notes by running ``towncrier build --draft --version=V.vv``.
``towncrier`` can be installed from PyPI or conda-forge.
