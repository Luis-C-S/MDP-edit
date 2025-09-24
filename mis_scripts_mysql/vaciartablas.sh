#!/bin/bash

if [ $# -eq 0 ]; then
    # No se pasaron parÃ¡metros: vaciar todas las tablas
    tablas=$(mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" -N -e "SHOW TABLES;")
else
    # Usar los parÃ¡metros como nombres de tablas
    tablas="$@"
fi

for tabla in $tablas; do
    echo "Vaciando tabla $tabla..."
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" -e "TRUNCATE TABLE \`$tabla\`;"
done