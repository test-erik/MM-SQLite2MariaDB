# MM-SQLite2MariaDB
## Convert a Mailman3 Database from SQLite to MariaDB

In the standard installation under Debian, Mailman3 uses an SQLite database. At some point, however, you will want to switch to a real database. The mechanism described in the Mailman documentation does not refer to Mailman3 as it is delivered by the distributions.

https://docs.mailman3.org/projects/mailman/en/latest/src/mailman/docs/database.html#database-migrations

The reason for this repository is that it was not obvious to create the schema for the databases and the order of the SQLite dumps in such a way that Mailman is satisfied afterwards.

## How to proceed

Two databases need to be converted, the one from the archive (Hyperkitty) and the actual Mailman3 database. First, I came up with a great script that takes into account the dependencies with foreign keys when creating tables using topological sorting. (Finally I could put my knowledge of graph theory to practical use!) But Mailman uses circular dependencies. In practice, this means that statements are broken down in such a way that the foreign keys are only inserted after all tables have been created.

### Converting the archive
* apply `mailmandb_web-to-mariadb.sql`
* dump the archive from `/var/lib/mailman3/web/mailman3web.db` (in the right order, pay attention to dependencies)
* substitue strings that are allowed in SQLite but not MariaDB
* insert the dump file

All these steps are done by calling `convert_mailman3web.sh`.

### Converting the archive
* apply `mailman.sql`
* dump the archive from `/var/lib/mailman3/data/mailman.db` (in the right order, pay attention to dependencies)
* insert the dump file

All these steps are done by calling `convert_mailman.sh`.

## A warning

The scripts were created ad-hoc. Especially when it comes to replacements in the archive, you might encounter different problems than I did.
