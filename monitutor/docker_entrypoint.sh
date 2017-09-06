#!/bin/bash

set -e

APPCONFIG_FILE="/var/www/web2py/applications/MoniTutor/private/appconfig.ini"

sed -i s/"database_host =.*"/"database_host = $DATABASE_HOST"/  $APPCONFIG_FILE
sed -i s/"database_user =.*"/"database_user = $DATABASE_USER"/  $APPCONFIG_FILE
sed -i s/"database_name =.*"/"database_name = $DATABASE_NAME"/  $APPCONFIG_FILE
sed -i s/"database_password =.*"/"database_password = $DATABASE_PASSWORD"/  $APPCONFIG_FILE
sed -i s/"icinga2_database_name =.*"/"icinga2_database_name = $ICINGA2_DATABASE_NAME"/  $APPCONFIG_FILE
sed -i s/"icinga2_api_user =.*"/"icinga2_api_user = $ICINGA2_API_USERNAME"/  $APPCONFIG_FILE
sed -i s/"icinga2_api_password =.*"/"icinga2_api_password = $ICINGA2_API_PASSWORD"/  $APPCONFIG_FILE
sed -i s/"icinga2_api_host =.*"/"icinga2_api_host = $ICINGA2_API_HOST"/  $APPCONFIG_FILE

echo "default_application = 'MoniTutor'" > /var/www/web2py/routes.py

exec $@
