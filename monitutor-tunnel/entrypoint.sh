#!/bin/bash

echo "database: $DATABASE_NAME" > ./appconfig.yaml
echo "username: $DATABASE_USER" >> ./appconfig.yaml
echo "password: $DATABASE_PASSWORD" >> ./appconfig.yaml
echo "host: $DATABASE_HOST" >> ./appconfig.yaml

while ! test -e /run/icinga2/cmd/icinga2.cmd; do
    echo "Icinga2 cmd pipe not available yet. Try again in 5 sec."
    sleep 5
done
exec "$@"
