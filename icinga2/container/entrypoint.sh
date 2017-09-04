#!/bin/bash

set -e

if [ ! -f /container/.installed ]; then
	if [ ! -f /container/.psql-installed ]; then
		export PGPASSWORD=$ICINGA2_DATABASE_PASSWORD
        while ! psql -h $ICINGA2_DATABASE_HOST -U $ICINGA2_DATABASE_USERNAME -d $ICINGA2_DATABASE_NAME; do
            echo "Couldn't connect to Database. Try again in 5 seconds..."
            sleep 5
        done
		echo "Setting up PostgreSQL Database"
		psql -h $ICINGA2_DATABASE_HOST -U $ICINGA2_DATABASE_USERNAME -d $ICINGA2_DATABASE_NAME < /usr/share/icinga2-ido-pgsql/schema/pgsql.sql
		icinga2 feature enable ido-pgsql
        echo \
"library \"db_ido_pgsql\"

object IdoPgsqlConnection \"ido-pgsql\" {
  user = \"$ICINGA2_DATABASE_USERNAME\",
  password = \"$ICINGA2_DATABASE_PASSWORD\",
  host = \"$ICINGA2_DATABASE_HOST\",
  database = \"$ICINGA2_DATABASE_NAME\"
}" > /etc/icinga2/features-enabled/ido-pgsql.conf

    	touch /container/.psql-installed
	fi
	icinga2 api setup
 	echo \
"object ApiUser \"$ICINGA2_API_USERNAME\" {
	password = \"$ICINGA2_API_PASSWORD\"
	permissions = [ \"*\" ]
}" > /etc/icinga2/features-enabled/api.conf
touch /container/.installed
fi

exec "$@"
