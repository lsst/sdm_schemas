# Recording Changes

This directory contains "news fragments" which are small files containing text that will be integrated into release notes.
The files can be in restructured text format or plain text.

Each file should be named like `<JIRA TICKET>.<TYPE>` with a file extension defining the markup format.
The `<TYPE>` corresponds to a particular schema category and should be one of:

- `dr`: Data Release (DR) and Data Preview (DP) schemas
- `sci`: Science Pipelines schemas under continuous development (ImSim and HSC)
- `ap`: Alert Production Database (APDB)
- `cdb`: Consolidated Database of Image Metadata (ConsDB)

**If the changes affect more than one type of schema, such as both `sci` and `ap`, then a separate fragment should be added for each using the same Jira ticket.**

For non-schema-related changes, this type should be used:

- `misc`: Miscellaneous changes (_not_ to include schema updates)

An example file name could therefore look like `DM-12345.misc.rst` or `DM-67890.ci.md`.

The news fragments do not have to be written as complete sentences, but past tense should be used as it is most appropriate for release notes, e.g., "Added ra field." and not "Add ra field."

You can test how the content will be integrated into the release notes by running:

```bash
towncrier build --draft --version=V.vv