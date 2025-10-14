<?php
// src/Controller/EntityController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class EntityController extends AbstractController
{
    private Connection $conn;
    private string $schema;

    public function __construct(Connection $conn)
    {
        $this->conn = $conn;
        $this->schema = 'mdp_products';

        // Forzar search_path para toda la sesión
        $this->conn->executeQuery("SET search_path TO {$this->schema},public");
    }

    /**
     * Comprueba si un valor es JSON
     */
    private function isJson($string): bool
    {
        if (!is_string($string)) return false;
        json_decode($string);
        return (json_last_error() === JSON_ERROR_NONE);
    }

    /**
     * Normaliza valores especiales de PostgreSQL a PHP
     */
    private function normalizeRow(array $row): array
    {
        foreach ($row as $col => &$val) {
            if (is_string($val)) {
                // JSON o JSONB
                if ($this->isJson($val)) {
                    $val = json_decode($val, true);
                }
                // Arrays de PostgreSQL {a,b,c}
                elseif (str_starts_with($val, '{') && str_ends_with($val, '}')) {
                    $val = explode(',', trim($val, '{}'));
                }
            }
        }
        return $row;
    }

    /**
     * Obtiene todos los registros de una tabla (GET)
     */
    #[Route('/tabla/{tableName}', name: 'api_table_get', methods: ['GET'])]
    public function getTableData(string $tableName): JsonResponse
    {
        try {
            $fullTableName = "{$this->schema}.\"$tableName\"";
            $rows = $this->conn->fetchAllAssociative("SELECT * FROM $fullTableName");

            // Normalizamos cada fila
            $rows = array_map([$this, 'normalizeRow'], $rows);

            return $this->json($rows);
        } catch (\Exception $e) {
            return $this->json([
                'error' => 'Error al obtener los datos: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Actualiza o inserta registros (POST)
     */
    #[Route('/tabla/{tableName}', name: 'api_table_post', methods: ['POST'])]
    public function updateTableData(string $tableName, Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!$data || !isset($data['action'], $data['row'])) {
            return $this->json(['ok' => false, 'error' => 'Petición malformada'], 400);
        }

        $action = $data['action'];
        $row = $data['row'];

        try {
            $fullTableName = "{$this->schema}.\"$tableName\"";

            if ($action === 'update') {
                if (!isset($row['id'])) {
                    return $this->json(['ok' => false, 'error' => 'Falta ID'], 400);
                }

                $id = $row['id'];
                unset($row['id']);

                $sets = implode(', ', array_map(fn($col) => "\"$col\" = :$col", array_keys($row)));
                $sql = "UPDATE $fullTableName SET $sets WHERE id = :id";

                $stmt = $this->conn->prepare($sql);
                $stmt->executeStatement([...$row, 'id' => $id]);
            }

            if ($action === 'insert') {
                $cols = implode(', ', array_map(fn($col) => "\"$col\"", array_keys($row)));
                $placeholders = implode(', ', array_map(fn($col) => ":$col", array_keys($row)));
                $sql = "INSERT INTO $fullTableName ($cols) VALUES ($placeholders)";

                $stmt = $this->conn->prepare($sql);
                $stmt->executeStatement($row);
            }

            return $this->json(['ok' => true]);
        } catch (\Exception $e) {
            return $this->json([
                'ok' => false,
                'error' => 'Error al actualizar/insertar: ' . $e->getMessage()
            ], 500);
        }
    }
}
