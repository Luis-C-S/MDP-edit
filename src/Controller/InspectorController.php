<?php

namespace App\Controller;

use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class InspectorController extends AbstractController
{
    #[Route('/inspector', name: 'app_inspector')]
    public function index(Connection $conn, Request $request): Response
    {
        $database = 'app'; // tu base de datos
        $selectedField = $request->query->get('field');

        // 1️⃣ Obtener todos los nombres de campo de la BBDD
        $fields = $conn->fetchFirstColumn("
            SELECT DISTINCT COLUMN_NAME 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_SCHEMA = :db 
            ORDER BY COLUMN_NAME
        ", ['db' => $database]);

        $tables = [];
        if ($selectedField) {
            // 2️⃣ Buscar tablas que contienen ese campo
            $tables = $conn->fetchAllAssociative("
                SELECT TABLE_NAME 
                FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = :db 
                  AND COLUMN_NAME = :field
                ORDER BY TABLE_NAME
            ", [
                'db' => $database,
                'field' => $selectedField
            ]);
        }
        

        return $this->render('inspector/index.html.twig', [
            'fields' => $fields,
            'selectedField' => $selectedField,
            'tables' => $tables,
        ]);
    }
}
