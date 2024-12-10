#!/bin/bash

set -e

# set -x
# Eingabedatei
DUMP_FILE="dump-mailman3web.sql"
SQLITE_WEBDB=/var/lib/mailman3/web/mailman3web.db
MARIADB_WEBDB=mailman3_web

echo "SET FOREIGN_KEY_CHECKS = 0;" > $DUMP_FILE
echo "SET NAMES utf8mb4;" >> $DUMP_FILE

## später löschen!
# ↓
#cat <<EOF | mariadb -h localhost -u root -p<SECRET>
#DROP DATABASE $MARIADB_WEBDB;
#CREATE DATABASE $MARIADB_WEBDB;
#USE $MARIADB_WEBDB;
#EOF

# for i in {1..14} ; do mariadb -h localhost -u root -p42hackware mailman3 < mailmandb-to-mariadb$i.sql ; done
mariadb -h localhost -u root -p<SECRET> $MARIADB_WEBDB < mailmandb_web-to-mariadb.sql
# ↑
## später löschen!

TABLES="
auth_user
django_content_type
account_emailaddress
account_emailconfirmation
auth_group
auth_group_permissions
auth_permission
auth_user_groups
auth_user_user_permissions
django_admin_log
django_session
django_site
django_mailman3_maildomain
django_mailman3_profile
django_migrations
django_q_ormq
django_q_schedule
django_q_task
hyperkitty_mailinglist
hyperkitty_sender
hyperkitty_email
hyperkitty_attachment
hyperkitty_favorite
hyperkitty_lastview
hyperkitty_mailinglist_moderators
hyperkitty_mailinglist_owners
hyperkitty_profile
hyperkitty_tagging
hyperkitty_tag
hyperkitty_threadcategory
hyperkitty_thread
hyperkitty_vote
postorius_emailtemplate
socialaccount_socialaccount
socialaccount_socialapp
socialaccount_socialapp_sites
socialaccount_socialtoken
"

for table in $TABLES ; do
    echo -n "$table "
    sqlite3 -readonly $SQLITE_WEBDB ".mode insert $table" "SELECT * FROM $table;" >> $DUMP_FILE
done
echo 

cp "$DUMP_FILE" "${DUMP_FILE}.bak"

echo "Bearbeite den Dump: $DUMP_FILE"
set -x

sed -i -e 's/"//g; s/AUTOINCREMENT/AUTO_INCREMENT/g' "$DUMP_FILE"

sed -i -e "s/\\\^//g; s/\\\''//g; s/:-\\\/:-\//g; s/ DEFERRABLE INITIALLY DEFERRED//g" "$DUMP_FILE"  # '

sed -i -e 's/\bTRUE\b/1/g; s/\bFALSE\b/0/g; s/\binteger\b/INT/gI; s/\bbool\b/TINYINT(1)/gI' "$DUMP_FILE"

sed -i -e "/^CREATE/d; /INSERT INTO sqlite_sequence/d" "$DUMP_FILE"

echo "Anpassungen abgeschlossen. Eine Sicherung wurde unter ${DUMP_FILE}.bak gespeichert."

mariadb -h localhost -u root -p42hackware $MARIADB_WEBDB <  $DUMP_FILE

