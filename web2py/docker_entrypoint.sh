#!/bin/bash

set -e

APPCONFIG_FILE="/var/www/web2py/applications/MoniTutor/private/appconfig.ini"

sed -i s/"database_host =.*"/"database_host = $DATABASE_HOST"/  $APPCONFIG_FILE
sed -i s/"database_user =.*"/"database_user = $DATABASE_USER"/  $APPCONFIG_FILE
sed -i s/"database_name =.*"/"database_name = $DATABASE_NAME"/  $APPCONFIG_FILE
sed -i s/"database_password =.*"/"database_password = $DATABASE_PASSWORD"/  $APPCONFIG_FILE
cat $APPCONFIG_FILE

echo "default_application = 'MoniTutor'" > /var/www/web2py/routes.py

exec /var/www/docker_entrypoint.sh $@
