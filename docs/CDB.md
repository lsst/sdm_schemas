Consolidated Database (CDB) Schema
==================================

The `cdb_*` schemas describe the [Consolidated Database](https://dmtn-227.lsst.io), consisting of information from observatory systems and data processing that is organized around exposures and visits (or similar data-taking-relevant dimensions).

Schema Versioning
-----------------

The schemas are semantically versioned with respect to consuming read-only clients and producing clients that write only their own tables.
A client that knows how to work with one version of the schema should be able to successfully work with future versions of the schema that have not changed major version number.

Typical Schema Changes
----------------------

Here are some guidelines for incrementing the version number based on what changes are being performed:

| Operation | Increment | Notes |
|--------|-----------|-------|
| Add table | `MINOR` | This is similar to a new compatible feature.  All existing clients can continue to operate normally; an updated producer may now write to the new table. |
| Add column with default | `MINOR` | This is also a new feature.  Existing clients can continue to operate normally. |
| Add column without default | `MINOR` | While the client that produces this column will have to be updated, all others can continue to operate normally. We will stretch the semantic versioning a little and avoid a major version change here. |
| Remove column or table | `MAJOR` | Consuming clients plus the client that produced this column or table will no longer be able to use this object and must be upgraded. |
| Change column or table name | `MAJOR` | This is the equivalent of a removal and addition. |
| Change column type | `MAJOR` or `PATCH` | This may or may not be completely transparent and so could be either incompatible or fully compatible. |
| Add index | `PATCH` | This should be fully backward compatible. |
| Change object metadata | `PATCH` | This does not affect the database schema, but it does affect how it is presented to the user. |

Database Migrations
-------------------

Changes to the CDB schemas must be deployed by generating an Alembic migration in the [consdb](https://github.com/lsst-dm/consdb) repository, deploying that migration to all necessary databases, ensuring proper replication, and deploying a new version of the data source for additions.  In addition, TAP Schema tables need to be generated and deployed for the interface to the RSP TAP query service.  See the [consdb Operator Guide](https://consdb.lsst.io/operator-guide/schema-migration-process.html) for more details.

Reviewers
---------

Adding information to `sdm_schemas` for ConsDB does not automatically make it appear in the database.
This is only one step in the contribution process sketched in the [consdb Contributor Guide](https://consdb.lsst.io/contributor-guide/adding-columns.html).
Reviews are only of the suitability of the schema documentation.

- Any member of the Data Engineering Team, as representatives of the consuming end users, for table and column naming, units, UCDs, and description text.
- Any member of the ConsDB team (currently [Brian Brondel](https://github.com/bbrondel) and [Kian-Tat Lim](https://github.com/ktlim)), as representatives of the producers, for data source and database compatibility.
