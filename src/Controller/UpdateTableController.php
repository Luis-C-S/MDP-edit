<?php
// src/Controller/UpdateTableController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class UpdateTableController extends AbstractController
{
    #[Route('/api/update-table/{tableName}', name: 'api_update_table', methods: ['POST'])]
    public function updateTable(string $tableName, Request $request, Connection $conn): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (!$data) {
            return new JsonResponse(['error' => 'JSON inválido'], 400);
        }

        $deleted = $data['delete'] ?? [];
        $updated = $data['update'] ?? [];
        $inserted = $data['insert'] ?? [];

        // Construimos el nombre completo de la tabla con schema
        $schema = 'mdp_products';
        $fullTable = $schema . '.' . $tableName;

        try {
            $conn->beginTransaction();

            // DELETE
            foreach ($deleted as $row) {
                if (!isset($row['id'])) continue;
                $conn->delete($fullTable, ['id' => $row['id']]);
            }

            // UPDATE
            foreach ($updated as $row) {
                if (!isset($row['id'])) continue;
                $id = $row['id'];
                unset($row['id']);
                $conn->update($fullTable, $row, ['id' => $id]);
            }

            // INSERT
            foreach ($inserted as $row) {
                // Si id es autoincrement, lo quitamos para que PostgreSQL lo genere
                if (isset($row['id'])) {
                    unset($row['id']);
                }
                $conn->insert($fullTable, $row);
            }

            $conn->commit();

            // Devolver todas las filas actuales de la tabla
            $rows = $conn->fetchAllAssociative("SELECT * FROM $fullTable");

            return new JsonResponse(['updatedData' => $rows]);
        } catch (\Exception $e) {
            $conn->rollBack();
            return new JsonResponse(['error' => $e->getMessage()], 500);
        }
    }
}
