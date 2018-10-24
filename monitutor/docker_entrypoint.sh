#!/bin/bash

set -e

cd /var/www/web2py/
python -c "from gluon.main import save_password; save_password('$WEB2PY_ADMIN_PW',80)"
python -c "from gluon.main import save_password; save_password('$WEB2PY_ADMIN_PW',443)"

if [ ! -f /etc/apache2/ssl/cacert.pem ]; then
    cat >&2 <<-EOT
ERROR: No CA-cert found. In order to use all MoniTutor features, you need
to have a CA in place. A self-signed CA and a self signed cert signed by that ca
will be created for you. To change the default subjects, set CA_SUBJECT and
CERT_SUBJECT by setting the environment variables. In order to use your own
certificates, mount your cert files and keys to /etc/apache2/ssl. They need to
be named "cacert.pem" "key.pem" and "cert.pem".
EOT
    cd /etc/apache2/ssl
    openssl genrsa 2048 > ca.key  && chmod 400 ca.key
    openssl req -x509 -new -nodes -key ca.key -sha256 -days 3650 -subj "$CA_SUBJECT" > cacert.pem
    openssl genrsa 2048 > key.pem && chmod 400 key.pem
    openssl req -new -key key.pem -subj "$CERT_SUBJECT" > cert.csr
    openssl x509 -req -in cert.csr -CA cacert.pem -CAkey ca.key -CAcreateserial -days 3650 -sha256 > cert.pem
fi

APPCONFIG_FILE="/var/www/web2py/applications/MoniTutor/private/appconfig.ini"

chown -R www-data:www-data /var/www/web2py/applications/MoniTutor/databases
chown -R www-data:www-data /var/www/web2py/applications/MoniTutor/uploads

sed -i s/"database_host =.*"/"database_host = $DATABASE_HOST"/  $APPCONFIG_FILE
sed -i s/"database_user =.*"/"database_user = $DATABASE_USER"/  $APPCONFIG_FILE
sed -i s/"database_name =.*"/"database_name = $DATABASE_NAME"/  $APPCONFIG_FILE
sed -i s/"database_password =.*"/"database_password = $DATABASE_PASSWORD"/  $APPCONFIG_FILE
sed -i s/"rabbit_mq_external_address =.*"/"rabbit_mq_external_address = $EXTERNAL_ADDRESS"/  $APPCONFIG_FILE
sed -i s/"rabbit_mq_websocket_port =.*"/"rabbit_mq_websocket_port = $EXTERNAL_RABBITMQ_WS_PORT"/  $APPCONFIG_FILE
sed -i s/"couchdb_username =.*"/"couchdb_username = $COUCHDB_USER"/  $APPCONFIG_FILE
sed -i s/"couchdb_password =.*"/"couchdb_password = $COUCHDB_PASSWORD"/  $APPCONFIG_FILE

echo "default_application = 'MoniTutor'" > /var/www/web2py/routes.py

exec $@
