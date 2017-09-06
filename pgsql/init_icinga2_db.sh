#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $ICINGA2_DATABASE_USERNAME WITH PASSWORD '$ICINGA2_DATABASE_PASSWORD';
    CREATE DATABASE $ICINGA2_DATABASE_NAME;
    GRANT ALL PRIVILEGES ON DATABASE $ICINGA2_DATABASE_NAME TO $ICINGA2_DATABASE_USERNAME;
    GRANT ALL PRIVILEGES ON DATABASE $ICINGA2_DATABASE_NAME TO $DATABASE_USER;
EOSQL
