#!/bin/bash

set -e

if [ ! -f /etc/icinga2/conf.d/.installed ]; then
	if [ ! -f /etc/icinga2/conf.d/.psql-installed ]; then
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
	touch /etc/icinga2/conf.d/.psql-installed
	fi
	icinga2 api setup
 	echo \
"object ApiUser \"$ICINGA2_API_USERNAME\" {
	password = \"$ICINGA2_API_PASSWORD\"
	permissions = [ \"*\" ]
}" >> /etc/icinga2/conf.d/api-users.conf
    icinga2 feature enable api
    icinga2 feature enable command
    touch /etc/icinga2/conf.d/.installed
fi

exec "$@"
