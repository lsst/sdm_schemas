Contributing to SDM Schemas
===========================

Creating a PR
-------------

All changes to the repository must be made by [opening a pull request](https://github.com/lsst/sdm_schemas/compare), which will require one approving reviewer. Any branches used for PRs which contain non-trivial changes should follow the [standard DM naming convention for ticket branches](https://developer.lsst.io/work/flow.html#ticket-branches), or the PR will be rejected and closed.

The PR title should be formatted like: `[TICKET]: [TITLE]` where `TICKET` is the Jira ticket and `TITLE` is a short description.

For example, this is a valid PR title, using a dummy ticket number:

`DM-12345: Add ra and dec columns to test schema`.

Including the name of the schema in the PR title is also helpful, e.g., `test` in this case.

The description body of the PR should contain clear information on what is being changed in the schema, though this may be fairly brief.
A set of bullet points describing each change will usually suffice.
The Jira ticket page can be used as a source of extended information on the issue being resolved.

An appropriate reviewer should be assigned, based on which schema is being changed or added. If the author does not know who should review their PR, [JeremyMcCormick](https://github.com/JeremyMcCormick) can be assigned as a default, and an appropriate reviewer will be found.

The author should [resolve the review](https://developer.lsst.io/work/flow.html#resolving-a-review) if changes are requested. Once the PR is approved, it may then be merged by the author.

Schema Versioning
-----------------

A pull request may necessitate an update to the schema's version.

Usage of semantic versioning is recommended, which defines a version like `MAJOR.MINOR.PATCH`, such as `1.2.3`.

The following generic guidelines can be used for this versioning scheme:

- `MAJOR`: Breaking changes that are not backward compatible.
- `MINOR`: Backward-compatible changes.
- `PATCH`: Backward-compatible changes, typically those that do not change the database schema.

Exactly how these versions are used and incremented is typically schema-dependent, and the [specific schema documentation](#specific-schema-documentation) should be consulted for those rules and guidelines.

Typical Schema Changes
----------------------

Here are some guidelines for incrementing the version number based on what changes are being performed:

| Change | Increment | Notes |
|--------|-----------|-------|
| Adding a table | `MAJOR` | Clients will want to access the new table, so this is backward incompatible.
| Adding a column | `MAJOR` | Clients will want to access the new column, so this is incompatible with the existing schema.|
| Removing a column | `MINOR` | Clients should not care about a missing column, so this should be backward compatible.|
| Changing column type | `MINOR` or `PATCH` | This may not be backward compatible depending on client implementation, so the version should be changed accordingly.
| Adding an index | `PATCH` | This should be fully backward compatible.|
| Adding a constraint | `PATCH` | This should be fully backward compatible.|
| Changing object metadata | - | This does not affect the database schema and should not require a version change.|

Documentation for specific schemas may supercede or augment the above guidelines.

Database Migration
------------------

Database migrations are currently performed with schema-specific tooling in external repositories, so documentation for that particular schema should be consulted on how to perform them and how this may impact the pull request process.

Specific Schema Documentation
-----------------------------

- [Alert Production Database (APDB)](docs/APDB.md)
