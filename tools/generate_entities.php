<?php

use Doctrine\DBAL\DriverManager;
use Doctrine\DBAL\Schema\SchemaException;

require_once __DIR__ . '/../vendor/autoload.php';

// --- Configuración de conexión ---
$connectionParams = [
    'dbname'   => 'app',
    'user'     => 'root',
    'password' => 'root',
    'host'     => 'mysql',
    'driver'   => 'pdo_mysql',
];
$conn = DriverManager::getConnection($connectionParams);

// --- Obtener las tablas ---
$schemaManager = $conn->createSchemaManager();
$tables = $schemaManager->listTables();

// --- Directorio de destino ---
$targetDir = __DIR__ . '/../src/Entity';
if (!is_dir($targetDir)) {
    mkdir($targetDir, 0777, true);
}

// --- Funciones auxiliares ---
function tableToClassName(string $tableName): string {
    return str_replace(' ', '', ucwords(str_replace('_', ' ', $tableName)));
}

function mapDbalTypeToOrmAndPhp($column): array {
    $type = get_class($column->getType());

    return match($type) {
        'Doctrine\DBAL\Types\StringType',
        'Doctrine\DBAL\Types\TextType',
        'Doctrine\DBAL\Types\GuidType' => ['orm' => 'string', 'php' => '?string'],

        'Doctrine\DBAL\Types\IntegerType',
        'Doctrine\DBAL\Types\BigIntType',
        'Doctrine\DBAL\Types\SmallIntType' => ['orm' => 'integer', 'php' => '?int'],

        'Doctrine\DBAL\Types\BooleanType' => ['orm' => 'boolean', 'php' => '?bool'],

        'Doctrine\DBAL\Types\FloatType',
        'Doctrine\DBAL\Types\DecimalType' => ['orm' => 'float', 'php' => '?float'],

        'Doctrine\DBAL\Types\DateTimeType',
        'Doctrine\DBAL\Types\DateTimeTzType',
        'Doctrine\DBAL\Types\DateType',
        'Doctrine\DBAL\Types\TimeType' => ['orm' => 'datetime', 'php' => '?\DateTimeInterface'],

        'Doctrine\DBAL\Types\JsonType',
        'Doctrine\DBAL\Types\JsonArrayType',
        'Doctrine\DBAL\Types\SimpleArrayType' => ['orm' => 'json', 'php' => '?array'],

        default => ['orm' => 'string', 'php' => '?string'],
    };
}

// --- Generación de entidades ---
foreach ($tables as $table) {
    $className = tableToClassName($table->getName());
    $filePath = "$targetDir/$className.php";

    $fields = "";
    foreach ($table->getColumns() as $column) {
        $map = mapDbalTypeToOrmAndPhp($column);
        $fields .= "    #[\Doctrine\ORM\Mapping\Column(type: '{$map['orm']}')]\n";
        $fields .= "    public {$map['php']} \${$column->getName()};\n\n";
    }

    $content = <<<PHP
<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class $className
{
$fields}
PHP;

    file_put_contents($filePath, $content);
    echo "✔ Entidad generada: $className\n";
}

echo "✅ Todas las entidades se han generado en src/Entity\n";
