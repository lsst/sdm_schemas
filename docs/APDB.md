Alert Production Database (APDB) Schema
=======================================

The [apdb](./python/lsst/sdm_schemas/schemas/apdb.yaml) schema describes the Alert Production Database (APDB).
This database is updated by the [Alert Production Pipeline](https://github.com/lsst/ap_pipe) and used for nightly [ap_verify](https://github.com/lsst/ap_verify) runs within continuous integration.
Previous processing runs may differ from the current schema.
The user-queryable Prompt Products Database (PPDB) is expected to have a very similar schema to the APDB.

Schema Versioning
-----------------

The versioning system of the APDB is outlined in [DMTN-269](https://dmtn-269.lsst.io/).
The deployed database schema is a product of the [schema in sdm_schemas](yml/apdb.yaml) and processing by tools in the [dax_apdb](https://github.com/lsst/dax_apdb) repository.
Compatibility of the client executable with the actual database schema is determined by the version number in `apdb.yaml` and that which is stored in the database metadata.

Backward compatibility in the context of the APDB implies that a client using an interface derived from a schema with a higher `MINOR` version number will be able to read and write into a database with a lower `MINOR` version.
But a client using a lower `MINOR` version number will not be compatible with a database that contains the changes from a higher version.
There may be cases where significant schema changes may still be compatible if the client can handle them transparently.

Typical Schema Changes
----------------------

Here are some guidelines for incrementing the version number based on what changes are being performed:

| Change | Increment | Notes |
|--------|-----------|-------|
| Adding a table | `MAJOR` | The client using the new schema will typically want to read or write into that column, which will make it incompatible.|
| Adding a column | `MAJOR` | Clients using the new schema will not care about a removed column, so this should be backward compatible.|
| Removing a column | `MINOR` or `PATCH` | This may or may not be fully backward compatible, depending on downstream client implementation and behavior.|
| Changing column type | `MINOR` or `PATCH` | This may or may not be completely transparent and so could be either backward compatible or fully compatible.
| Adding an index | `PATCH` | This should be fully backward compatible.|
| Changing object metadata | - | This does not affect the database schema and should not require a version change.|

Client Compatibility
--------------------

Changes to the APDB schema must be propagated to the API defined in the [api_packet](https://github.com/lsst/alert_packet) repository, following the instructions under [Adding a new schema](https://github.com/lsst/alert_packet/tree/main?tab=readme-ov-file#adding-a-new-schema).

Database Migrations
-------------------

The APDB database schema is upgraded using a special migration tool defined in the [dax_apdb_migrate](https://github.com/lsst-dm/dax_apdb_migrate) repository. For every version change to `apdb.yaml`, a new migration script needs to be added to that repository. The details of the migration process are described in the [package documentation](https://pipelines.lsst.io/modules/lsst.dax.apdb/index.html). Migration scripts should normally be implemented on the same Jira ticket as the corresponding schema change.

Reviewers
---------

- [Andy Salnikov](https://github.com/andy-slac)
