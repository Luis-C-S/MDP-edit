#!/bin/bash

# Si se pasan parámetros, solo borrar esas tablas
if [ $# -gt 0 ]; then
    tablas="$@"
else
    # Si no, borrar todas las tablas del esquema public
    tablas=$(psql -U app -d app -At -c "SELECT tablename FROM pg_tables WHERE schemaname='public';")
fi

for tabla in $tablas; do
    echo "Eliminando tabla $tabla..."
    psql -U app -d app -c "DROP TABLE IF EXISTS \"$tabla\" CASCADE;"
done
