#!/bin/bash

# Si se pasan parámetros, solo procesa esos CSV (buscando el archivo correspondiente)
if [ $# -gt 0 ]; then
    archivos=()
    for nombre in "$@"; do
        archivo="/csvs/tb_mdp_${nombre}.csv"
        if [ -f "$archivo" ]; then
            archivos+=("$archivo")
        else
            echo "No se encontró el archivo $archivo"
        fi
    done
else
    archivos=(/csvs/*.csv)
fi

for csvfile in "${archivos[@]}"; do
    base=$(basename "$csvfile" .csv)
    tablename=${base#tb_mdp_}

    echo "Rellenando tabla $tablename desde $csvfile..."
    mysql --local-infile=1 -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DATABASE" \
      -e "LOAD DATA LOCAL INFILE '$csvfile'
          INTO TABLE \`$tablename\`
          CHARACTER SET utf8
          FIELDS TERMINATED BY ';'
          ENCLOSED BY '\"'
          LINES TERMINATED BY '\n'
          IGNORE 1 ROWS;"
done
