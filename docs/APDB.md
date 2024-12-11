Alert Production Database (APDB) Schema
=======================================

The [apdb](../python/lsst/sdm_schemas/schemas/apdb.yaml) schema describes the Alert Production Database (APDB), which contains the results of processing from the [Alert Production Pipeline](https://github.com/lsst/ap_pipe).

Schema Versioning
-----------------

The versioning system of the APDB is outlined in [DMTN-269](https://dmtn-269.lsst.io/).
The deployed database schema is a product of the [schema in sdm_schemas](../python/lsst/sdm_schemas/schemas/apdb.yaml) with additional processing by the APDB client library from the [dax_apdb](https://github.com/lsst/dax_apdb) repository.
Compatibility of the client executable with the actual database schema is determined by the version number in the YAML file and the version stored in the database metadata.

Backward compatibility in the context of the APDB implies that a client using a schema with a higher minor version will be able to read and write into a database with a lower minor version -- in other words, an existing database instance need not be migrated to match the newer client interface.
But a client using a schema with a lower minor version will be incompatible with a database that has a higher version number.
There may be cases where significant schema changes may still be compatible if the client can handle them transparently.

Typical Schema Changes
----------------------

Here are some guidelines for incrementing the version number based on what changes are being performed:

| Operation | Increment | Notes |
|--------|-----------|-------|
| Add table | `MAJOR` | The client using the new schema will typically want to read or write into that table, which will make it incompatible.|
| Add column | `MAJOR` | The client using the new schema will typically want to read or write into that column, which will make it incompatible.|
| Remove column | `MINOR` or `PATCH` | Clients using the new schema will not care about a removed column, so this should be backward compatible.|
| Change column type | `MINOR` or `PATCH` | This may or may not be completely transparent and so could be either backward compatible or fully compatible.
| Add index | `PATCH` | This should be fully backward compatible.|
| Change object metadata | - | This does not affect the database schema and should not require a version change.|

Client Compatibility
--------------------

Changes to the APDB schema must be propagated to the Avro alert schemas defined in the [alert_packet](https://github.com/lsst/alert_packet) repository, following the instructions under [Adding a new schema](https://github.com/lsst/alert_packet/tree/main?tab=readme-ov-file#adding-a-new-schema).

Database Migrations
-------------------

The APDB database schema is upgraded using a special migration tool defined in the [dax_apdb_migrate](https://github.com/lsst-dm/dax_apdb_migrate) repository.
For every version change to `apdb.yaml`, a new migration script needs to be added to that repository.
The details of the migration process are described in the [package documentation](https://github.com/lsst-dm/dax_apdb_migrate/blob/main/doc/lsst.dax.apdb_migrate/index.rst).
The APDB includes a Cassandra-based implementation in addition to a SQL-based one, and the Cassandra implementation may impose additional restrictions on schema changes.
Migration scripts should normally be implemented on the same Jira ticket as the corresponding schema change.

Reviewers
---------

- [Ian Sullivan](https://github.com/isullivan) - primary reviewer (may reroute to another reviewer depending on changes)
- [Andy Salnikov](https://github.com/andy-slac) - for guidance on updating schema versions
