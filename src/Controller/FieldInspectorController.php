<?php
// src/Controller/FieldInspectorController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class FieldInspectorController extends AbstractController
{
    private Connection $connection;
    private string $schema;

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
        $this->schema = 'mdp_products';
        $this->connection->executeQuery('SET search_path TO mdp_products,public');
    }

    #[Route('/api/fields', name: 'api_fields', methods: ['GET'])]
    public function getFields(): JsonResponse
    {
        $fields = $this->connection->createQueryBuilder()
            ->select('COLUMN_NAME')
            ->from('INFORMATION_SCHEMA.COLUMNS')
            ->where('TABLE_SCHEMA = :schema')
            ->setParameter('schema', $this->schema)
            ->executeQuery()
            ->fetchFirstColumn();

        $uniqueSortedFields = array_unique($fields);
        sort($uniqueSortedFields, SORT_NATURAL | SORT_FLAG_CASE);

        return new JsonResponse($uniqueSortedFields);
    }

    #[Route('/api/tables/{field}', name: 'api_tables', methods: ['GET'])]
    public function getTables(string $field): JsonResponse
    {
        $tables = $this->connection->createQueryBuilder()
            ->select('TABLE_NAME')
            ->from('INFORMATION_SCHEMA.COLUMNS')
            ->where('TABLE_SCHEMA = :schema')
            ->andWhere('COLUMN_NAME = :field')
            ->setParameter('schema', $this->schema)
            ->setParameter('field', $field)
            ->executeQuery()
            ->fetchFirstColumn();

        return new JsonResponse($tables);
    }

    #[Route('/api/table/{tableName}', name: 'api_table_data', methods: ['GET'])]
    public function getTableData(string $tableName): JsonResponse
    {
        try {
            $fullTableName = "{$this->schema}.\"$tableName\"";
            $rows = $this->connection->fetchAllAssociative("SELECT * FROM $fullTableName");

            foreach ($rows as &$row) {
                foreach ($row as $col => $value) {
                    if (is_resource($value) || is_object($value)) {
                        $row[$col] = 'tipo no compatible';
                    }
                }
            }

            return new JsonResponse($rows);
        } catch (\Exception $e) {
            return new JsonResponse([
                'error' => 'Error al obtener los datos: ' . $e->getMessage()
            ], 500);
        }
    }
}
