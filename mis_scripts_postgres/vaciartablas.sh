#!/bin/bash

SCHEMA="mdp_producto"

if [ $# -eq 0 ]; then
    tablas=$(psql -U app -d app -At -c "SELECT tablename FROM pg_tables WHERE schemaname='${SCHEMA}';")
else
    tablas="$@"
fi

for tabla in $tablas; do
    echo "Vaciando tabla ${SCHEMA}.${tabla}..."
    psql -U app -d app -c "TRUNCATE TABLE \"${SCHEMA}\".\"${tabla}\" RESTART IDENTITY CASCADE;"
done
