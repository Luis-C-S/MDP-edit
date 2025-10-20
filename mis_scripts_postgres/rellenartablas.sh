#!/bin/bash

# ==========================================
# Script robusto de importación de CSVs a PostgreSQL
# Esquema: mdp_producto
# ==========================================

CSV_DIR="/csvs_postgres"
SCHEMA="mdp_products"

# Array de archivos a procesar
archivos=()

if [ $# -gt 0 ]; then
    # Procesar solo archivos especificados
    for nombre in "$@"; do
        archivo="$CSV_DIR/$nombre.csv"
        if [ -f "$archivo" ]; then
            archivos+=("$archivo")
        else
            echo "❌ No se encontró el archivo $archivo"
        fi
    done
else
    # Procesar todos los CSVs
    archivos=($CSV_DIR/*.csv)
fi

echo "🔧 Archivos a procesar: ${archivos[@]}"

for csvfile in "${archivos[@]}"; do
    tablename=$(basename "$csvfile" .csv)
    full_table="${SCHEMA}.${tablename}"
    echo "🌀 Procesando archivo: $csvfile"

    # Verificar existencia de la tabla
    exists=$(psql -U app -d app -tAc "SELECT to_regclass('$full_table');")
    if [ "$exists" != "$full_table" ]; then
        echo "❌ La tabla $full_table no existe, saltando..."
        continue
    fi

    # Verificar si la tabla ya tiene datos
    rowcount=$(psql -U app -d app -tAc "SELECT COUNT(*) FROM $full_table;")
    if [ "$rowcount" -gt 0 ]; then
        echo "⏭️  Tabla $full_table ya tiene $rowcount filas, saltando importación"
        continue
    fi

    # Obtener columnas válidas de la tabla (no GENERATED) en orden
    table_cols=$(psql -U app -d app -tAc "
        SELECT column_name
        FROM information_schema.columns
        WHERE table_schema='$SCHEMA' AND table_name='$tablename' AND is_generated='NEVER'
        ORDER BY ordinal_position;
    ")

    # Convertir columnas a CSV separadas por comas y con comillas dobles
    IFS=$'\n' read -rd '' -a cols_array <<<"$table_cols"
    if [ ${#cols_array[@]} -eq 0 ]; then
        echo "❌ No se encontraron columnas válidas para $full_table, saltando..."
        continue
    fi
    final_cols=$(printf '"%s",' "${cols_array[@]}")
    final_cols=${final_cols%,}  # quitar la última coma

    echo "📥 Columnas a importar: $final_cols"

    # Crear CSV temporal reordenado
    tmpfile=$(mktemp /tmp/tmp_csv.XXXXXX)

    # Mapear índices de columnas del CSV original
    header_line=$(head -n 1 "$csvfile")
    IFS=';' read -ra csv_cols <<<"$header_line"

    declare -A col_index_map
    for i in "${!csv_cols[@]}"; do
        col_name=$(echo "${csv_cols[$i]}" | tr -d '"')
        col_index_map["$col_name"]=$((i+1))
    done

    # Construir línea awk para reordenar columnas según la tabla
    awk_expr="BEGIN{FS=OFS=\";\"} {print "
    for i in "${!cols_array[@]}"; do
        col="${cols_array[$i]}"
        idx=${col_index_map[$col]}
        if [ -z "$idx" ]; then
            awk_expr+="\"\""
        else
            awk_expr+="\$${idx}"
        fi
        if [ $i -lt $((${#cols_array[@]}-1)) ]; then
            awk_expr+=","
        fi
    done
    awk_expr+="}"

    # Generar CSV temporal reordenado
    awk "$awk_expr" "$csvfile" > "$tmpfile"

    # Ejecutar importación con \copy
    psql -U app -d app -c "\copy $full_table($final_cols) FROM '$tmpfile' DELIMITER ';' CSV HEADER;"

    # Contar filas importadas
    newcount=$(psql -U app -d app -tAc "SELECT COUNT(*) FROM $full_table;")
    echo "✅ Importación completada. Filas actuales: $newcount"

    # Borrar CSV temporal
    rm "$tmpfile"
done
