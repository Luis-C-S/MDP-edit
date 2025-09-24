
#!/bin/bash


# Si se pasan parÃ¡metros, solo procesa esos CSV (buscando el archivo correspondiente)
if [ $# -gt 0 ]; then
    archivos=()
    for nombre in "$@"; do
        # Busca el archivo CSV que corresponde a la tabla (aÃ±adiendo el prefijo y extensiÃ³n)
        archivo="/csvs/tb_mdp_${nombre}.csv"
        if [ -f "$archivo" ]; then
            archivos+=("$archivo")
        else
            echo "No se encontrÃ³ el archivo $archivo"
        fi
    done
else
    # Si no se pasan parÃ¡metros, procesa todos los CSV
    archivos=(/csvs/*.csv)
fi

for csvfile in "${archivos[@]}"; do
    # Obtener el nombre de la tabla quitando el prefijo y la extensiÃ³n
    base=$(basename "$csvfile" .csv)
    tablename=${base#tb_mdp_}

    # Leer la cabecera para los nombres de columna
    header=$(head -n 1 "$csvfile")
    header_clean=$(echo "$header" | tr ';' ',')

    # Construir el CREATE TABLE
    IFS=',' read -ra columns <<< "$header_clean"
    create_sql="CREATE TABLE IF NOT EXISTS \`$tablename\` ("
    for col in "${columns[@]}"; do
        col_clean=$(echo "$col" | tr -d '\"')
        create_sql+="\`$col_clean\` VARCHAR(255),"
    done
    create_sql=${create_sql%,} # Quitar la Ãºltima coma
    create_sql+=");"

    echo "Creando tabla $tablename..."
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" -e "$create_sql"

    echo "Importando $csvfile en la tabla $tablename..."
    mysql --local-infile=1 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" \
      -e "LOAD DATA LOCAL INFILE '$csvfile'
          INTO TABLE \`$tablename\`
          CHARACTER SET utf8
          FIELDS TERMINATED BY ';'
          ENCLOSED BY '\"'
          LINES TERMINATED BY '\n'
          IGNORE 1 ROWS;"
done