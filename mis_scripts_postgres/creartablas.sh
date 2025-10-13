#!/bin/bash

# Carpeta donde están los CSVs en el contenedor
CSV_DIR="/csvs_postgres"

# Si se pasan parámetros, solo procesa esos CSV
if [ $# -gt 0 ]; then
    archivos=()
    for nombre in "$@"; do
        archivo="$CSV_DIR/$nombre.csv"
        if [ -f "$archivo" ]; then
            archivos+=("$archivo")
        else
            echo "No se encontró el archivo $archivo"
        fi
    done
else
    # Si no se pasan parámetros, procesa todos los CSV
    archivos=($CSV_DIR/*.csv)
fi

for csvfile in "${archivos[@]}"; do
    # Obtener el nombre de la tabla (con prefijo incluido)
    base=$(basename "$csvfile" .csv)
    tablename="$base"

    # Leer la cabecera para los nombres de columna
    header=$(head -n 1 "$csvfile")
    header_clean=$(echo "$header" | tr ';' ',')

    # Construir el CREATE TABLE
    IFS=',' read -ra columns <<< "$header_clean"
    create_sql="CREATE TABLE IF NOT EXISTS \"$tablename\" ("
    for col in "${columns[@]}"; do
        col_clean=$(echo "$col" | tr -d '\"')
        create_sql+="\"$col_clean\" VARCHAR(255),"
    done
    create_sql=${create_sql%,} # Quitar la última coma
    create_sql+=");"

    echo "Creando tabla $tablename..."
    psql -U app -d app -c "$create_sql"

    echo "Importando $csvfile en la tabla $tablename..."
    psql -U app -d app -c "\copy \"$tablename\"(${header_clean}) FROM '$csvfile' DELIMITER ';' CSV HEADER;"
done
