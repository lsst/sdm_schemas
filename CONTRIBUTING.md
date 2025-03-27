Contributing to SDM Schemas
===========================

Creating a PR
-------------

All changes to the repository must be made by [opening a pull request](https://github.com/lsst/sdm_schemas/compare), which will require one approving reviewer.
Any branches used for PRs which contain non-trivial changes should follow the [standard DM naming convention for ticket branches](https://developer.lsst.io/work/flow.html#ticket-branches), or the PR will be rejected and closed.

The PR title should be formatted like: `[TICKET]: [TITLE]` where `TICKET` is the Jira ticket number and `TITLE` is a short description.

For example, this is a valid PR title, with a dummy ticket number:

`DM-12345: Add ra and dec columns to test schema`.

Including the name of the schema in the PR title is also helpful for the reviewer and provenance, e.g., `test` in this case.

An appropriate reviewer should be assigned, based on which schema is being changed or added.
If the author does not know who should review their PR, [JeremyMcCormick](https://github.com/JeremyMcCormick) can be assigned as a default, and an appropriate reviewer will be found.

The author should [resolve the review](https://developer.lsst.io/work/flow.html#resolving-a-review) if changes are requested.
Once the PR is approved, it may then be merged by the author.

Pull Request Checks
-------------------

SDM Schemas pull requests have an extensive set of checks that will run automatically.
Aside from special cases, a pull request will have to pass all of these checks before it can be merged.

These checks will:

- [Build TAP_SCHEMA and DataLink resources](.github/workflows/build.yaml)
- [Compare Schemas for Changes](.github/workflows/compare.yaml) - Schemas that are in the [deployed list](./python/lsst/sdm/schemas/deployed-schemas.txt) will fail this check.
- [Build the Schema Browser website](.github/workflows/docs.yaml)
- [Check that `main` is not merged into the branch](.github/workflows/rebase_checker.yaml)
- [Test that the schemas can be used to create databases](.github/workflows/test_databases.yaml)
- [Vaildate the schemas using Felis](.github/workflows/validate.yaml)
- [Lint YAML files](.github/workflows/yamllint.yaml)

The checks will rerun anytime the PR branch is updated.

Schema Versioning
-----------------

Individual schemas may have their own internal [version](https://felis.lsst.io/user-guide/model.html#schema-version) for tracking changes, which is defined at the top of the file, as in [apdb.yaml](./python/lsst/sdm/schemas/apdb.yaml).
(This is distinct from tags or versions of sdm_schemas itself, and not all schemas may be using them.)
This version may need to be updated when making changes.

It is recommended to use versions with three numbers in the format `MAJOR.MINOR.PATCH`, such as `1.2.3`, though any scheme may be used in practice.

The following guidelines can be used for incrementing the version:

- Different `MAJOR` versions are incompatible.
- Different `MINOR` versions are backward compatible.
- Different `PATCH` versions are completely compatible.

These suggestions need not be followed strictly, and there may be exceptions.
For instance, some operations which are technically backward-compatible, such as adding a table, should likely trigger a `MAJOR` version increment rather than `MINOR`, as they would constitute an important and significant update, potentially requiring significant changes to client code or APIs.

The [specific schema documentation](#specific-schema-documentation) should be consulted for more specific rules and guidelines on version incrementing.

Database Migrations
-------------------

Database migrations are currently performed with schema-specific tooling in external repositories, so documentation for that particular schema should be consulted on how to perform them and how this may impact the pull request process.

Specific Schema Documentation
-----------------------------

- [Alert Production Database (APDB)](docs/APDB.md)
- [Consolidated Database (ConsDB)](docs/CDB.md)
- [Data Release Production](docs/DRP.md)
