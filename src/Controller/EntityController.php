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
        $this->conn->executeQuery('SET search_path TO mdp_products,public');
    }

    /**
     * Devuelve todas las filas de una tabla, ignorando tipos no soportados
     */
    #[Route('/tabla/{tableName}', name: 'api_table_get', methods: ['GET'])]
    public function getTableData(string $tableName): JsonResponse
    {
        try {
            $tableName = trim($tableName, '"'); // quitar comillas dobles si hay
            $fullTableName = "{$this->schema}.\"$tableName\"";

            $rows = $this->conn->fetchAllAssociative("SELECT * FROM $fullTableName");

            // Convertir tipos no soportados a string fijo

            array_walk_recursive($rows, function (&$value) {
                if (is_resource($value) || is_object($value)) {
                    $value = "tipo no compatible";
                }
            });


            return $this->json($rows);
        } catch (\Exception $e) {
            return $this->json([
                'error' => 'Error al obtener los datos: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Actualiza o inserta registros
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
            $tableName = trim($tableName, '"');
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
            return $this->json(['ok' => false, 'error' => $e->getMessage()], 500);
        }
    }
}
