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
    /**
     * ✅ Obtiene todos los registros de una tabla (GET)
     */
    #[Route('/tabla/{tableName}', name: 'api_table_get', methods: ['GET'])]
    public function getTableData(string $tableName, Connection $conn): JsonResponse
    {
        try {
            // Consulta todos los registros de la tabla indicada
            $rows = $conn->fetchAllAssociative("SELECT * FROM `$tableName`");
            return $this->json($rows);
        } catch (\Exception $e) {
            return $this->json(['error' => 'Error al obtener los datos: ' . $e->getMessage()], 500);
        }
    }

    /**
     * ✅ Actualiza o inserta registros (POST)
     * 
     * Recibe un JSON desde el front con esta forma:
     * {
     *   "action": "update",  // o "insert"
     *   "row": { "id": 1, "campo1": "valor", ... }
     * }
     */
    #[Route('/tabla/{tableName}', name: 'api_table_post', methods: ['POST'])]
    public function updateTableData(string $tableName, Connection $conn, Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!$data || !isset($data['action']) || !isset($data['row'])) {
            return $this->json(['ok' => false, 'error' => 'Petición malformada'], 400);
        }

        $action = $data['action'];
        $row = $data['row'];

        try {
            if ($action === 'update') {
                // Verifica que haya una columna 'id' para poder actualizar
                if (!isset($row['id'])) {
                    return $this->json(['ok' => false, 'error' => 'Falta ID'], 400);
                }

                $id = $row['id'];
                unset($row['id']);

                // Generar SQL dinámico de UPDATE
                $sets = implode(', ', array_map(fn($col) => "`$col` = :$col", array_keys($row)));
                $sql = "UPDATE `$tableName` SET $sets WHERE id = :id";

                $stmt = $conn->prepare($sql);
                $stmt->executeStatement([...$row, 'id' => $id]);
            }

            if ($action === 'insert') {
                // Generar SQL dinámico de INSERT
                $cols = implode(', ', array_map(fn($col) => "`$col`", array_keys($row)));
                $placeholders = implode(', ', array_map(fn($col) => ":$col", array_keys($row)));
                $sql = "INSERT INTO `$tableName` ($cols) VALUES ($placeholders)";

                $stmt = $conn->prepare($sql);
                $stmt->executeStatement($row);
            }

            return $this->json(['ok' => true]);
        } catch (\Exception $e) {
            return $this->json(['ok' => false, 'error' => $e->getMessage()], 500);
        }
    }
}
