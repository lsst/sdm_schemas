Contributing to SDM Schemas
===========================

Creating a PR
-------------

All changes to the repository must be done through the standard GitHub PR process. Direct changes to the `main` branch are disallowed by branch protection rules.

The PR title should be formatted like: `[TICKET]: [DESCRIPTION]` where `TICKET` is a Jira ticket, usually from Data Management, so `DM-#####`.

For example, this is a valid PR title (with a dummy ticket number):

`DM-12345: Add ra and dec columns`.

The description of the PR should contain clear information on what is being changed and why.

An appropriate reviewer should be assigned by the PR author based on which schema is being changed. If this is not known, [JeremyMcCormick](https://github.com/JeremyMcCormick) can be used as a default.

Schema Versioning
-----------------

A pull request may need to include an update to the schema's version.

Usage of semantic versioning is recommended, which defines a version like `MAJOR.MINOR.PATCH`, such as `1.2.3`.

The following guidelines should be used for this versioning scheme:

- Different `MAJOR` versions are not compatible.
- Different `MINOR` versions are backward compatible.
- Different `PATCH` versions are completely compatible.

Backward compatibility implies that a client using an interface derived from a schema with a higher `MINOR` version number will be able to read and write into a database with a lower `MINOR` version.
But a client using a lower `MINOR` version number will not be compatible with a database that contains the changes from a higher version.

There may be cases where significant schema changes may still be compatible if the client can handle them transparently.
In general, version changes will need to be evaluated on a case-by-case basis and may depend on the particular schema being updated.

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

Database migrations are currently performed with schema-specific tools, so documentation for that particular schema should be consulted on how to perform them and how this may impact the pull request procedure.

Specific Schema Documentation
-----------------------------

- [Alert Production Database (APDB)](docs/APDB.md)