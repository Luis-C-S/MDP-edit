<?php
// src/Controller/EntityController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

class EntityController extends AbstractController
{
    #[Route('/tabla/{tableName}', name: 'api_table', methods: ['GET'])]
    public function getTableData(string $tableName, Connection $conn): JsonResponse
    {
        // Consulta directa de todos los registros de la tabla
        $rows = $conn->fetchAllAssociative("SELECT * FROM `$tableName`");

        return $this->json($rows);
    }
}

