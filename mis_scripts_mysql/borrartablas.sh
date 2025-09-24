
#!/bin/bash


if [ $# -eq 0 ]; then
    # No se pasaron parÃ¡metros: borrar todas las tablas
    tablas=$(mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "app" -N -e "SHOW TABLES;")
else
    # Usar los parÃ¡metros como nombres de tablas
    tablas="$@"
fi

for tabla in $tablas; do
    echo "Eliminando tabla $tabla..."
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" -e "DROP TABLE IF EXISTS \`$tabla\`;"
done