<?php
// src/Controller/LookupController.php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

#[Route('/api/lookups')]
class LookupController extends AbstractController
{
    #[Route('/{table}', name: 'api_lookups', methods: ['GET'])]
    public function lookups(string $table, Connection $conn): JsonResponse
    {
        // 1️⃣ Buscar todas las relaciones definidas para esta tabla
        $fields = $conn->fetchAllAssociative("
            SELECT codigo AS campo_codigo, nombre_descripcion AS campo_descripcion, tabla_referencia
            FROM mdp_products._codigo_relacion
            WHERE tabla_origen = ?
        ", [$table]);

        if (!$fields) {
            return $this->json(['error' => 'No hay relaciones configuradas para esta tabla.'], 404);
        }

        $result = [];

        // 2️⃣ Para cada relación, cargar sus valores de referencia
        foreach ($fields as $f) {
            // Aseguramos que la tabla de referencia esté cualificada con el esquema correcto
            $tablaReferencia = "mdp_products." . $f['tabla_referencia'];

            $rows = $conn->fetchAllAssociative("
                SELECT {$f['campo_codigo']} AS {$f['campo_codigo']},
                       {$f['campo_descripcion']} AS {$f['campo_descripcion']}
                FROM {$tablaReferencia}
                ORDER BY {$f['campo_descripcion']}
            ");

            $result[$f['campo_codigo']] = $rows;
        }

        return $this->json($result);
    }
}
