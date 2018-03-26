#!/bin/bash

echo "database: $DATABASE_NAME" > ./appconfig.yaml
echo "username: $DATABASE_USER" >> ./appconfig.yaml
echo "password: $DATABASE_PASSWORD" >> ./appconfig.yaml
echo "host: $DATABASE_HOST" >> ./appconfig.yaml

sleep 15
exec "$@"
