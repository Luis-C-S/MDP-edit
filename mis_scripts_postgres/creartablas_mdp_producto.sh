#!/bin/bash

# ============================================================
# Crea tablas en el esquema mdp_producto a partir de CSVs
# Uso: ./creartablas.sh nombre_csv [nombre_csv2 ...]
# Ejemplo: ./creartablas.sh tb_mdp_zona_tarifaria tb_mdp_idioma
# ============================================================

# Carpeta donde están los CSVs dentro del contenedor
CSV_DIR="/csvs_postgres"
SCHEMA="mdp_products"

# Requiere al menos un parámetro
if [ $# -eq 0 ]; then
    echo "❌ Error: Debes indicar al menos un archivo CSV (sin la extensión)."
    echo "👉 Ejemplo: ./creartablas.sh tb_mdp_zona_tarifaria"
    exit 1
fi

# Procesar cada archivo pasado como argumento
for nombre in "$@"; do
    archivo="$CSV_DIR/$nombre.csv"

    if [ ! -f "$archivo" ]; then
        echo "❌ No se encontró el archivo $archivo, saltando..."
        continue
    fi

    tablename="$nombre"
    full_table="${SCHEMA}.${tablename}"

    echo "🧩 Creando tabla: $full_table a partir de $archivo"

    # Leer cabecera (nombres de columnas)
    header=$(head -n 1 "$archivo")
    header_clean=$(echo "$header" | tr ';' ',')

    # Construir SQL de creación de tabla
    IFS=',' read -ra columns <<< "$header_clean"
    create_sql="CREATE TABLE IF NOT EXISTS \"$SCHEMA\".\"$tablename\" ("
    for col in "${columns[@]}"; do
        col_clean=$(echo "$col" | tr -d '"' | xargs)
        create_sql+="\"$col_clean\" VARCHAR(255),"
    done
    create_sql=${create_sql%,}  # Quitar la última coma
    create_sql+=");"

    # Ejecutar creación
    psql -U app -d app -c "$create_sql"

    # Importar datos
    echo "📥 Importando datos desde $archivo..."
    psql -U app -d app -c "\copy \"$SCHEMA\".\"$tablename\" FROM '$archivo' DELIMITER ';' CSV HEADER;"

    echo "✅ Tabla $full_table creada e importada correctamente."
    echo
done
