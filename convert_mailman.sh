#!/bin/bash

set -e

# set -x
# Eingabedatei
DUMP_FILE="dump-mailman.sql"
SQLITE_DB=/var/lib/mailman3/data/mailman.db
MARIADB_DB=mailman3

echo "SET FOREIGN_KEY_CHECKS = 0;" > $DUMP_FILE

## später löschen!
# ↓
#cat <<EOF | mariadb -h localhost -u root -p<SECRET>
#DROP DATABASE IF EXISTS mailman;
#DROP DATABASE IF EXISTS $MARIADB_DB;
#CREATE DATABASE $MARIADB_DB;
#USE $MARIADB_DB;
#EOF

# Zuerst die Struktur (Schema) der DB anlegen
#mariadb -h localhost -u root -p<SECRET> $MARIADB_DB < mailman.sql
# ↑
## später löschen!


TABLES="
_request
bounceevent
listarchiver
pendedkeyvalue    
acceptablealias
contentfilter
mailinglist
preferences       
address
domain
member
template
alembic_version
domain_owner
message
uid               
autoresponserecord
file_cache
onelastdigest
user
ban
headermatch
pended
workflowstate     
"

echo "SET NAMES utf8mb4;" >> $DUMP_FILE

for table in $TABLES ; do
    echo -n "$table "
    sqlite3 -readonly $SQLITE_DB ".mode insert $table" "SELECT * FROM $table;" >> $DUMP_FILE
done
echo 




cp "$DUMP_FILE" "${DUMP_FILE}.bak"

echo "Bearbeite den Dump: $DUMP_FILE"

sed -i -e 's/"//g; s/AUTOINCREMENT/AUTO_INCREMENT/g' "$DUMP_FILE"

echo "Anpassungen abgeschlossen. Eine Sicherung wurde unter ${DUMP_FILE}.bak gespeichert."

mariadb -h localhost -u root -p<SECRET> $MARIADB_DB < "$DUMP_FILE"


exit

