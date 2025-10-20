<?php
// src/Controller/LookupController.php
// Controlador para manejar las solicitudes de búsqueda de catálogos de referencia (traducciones de códigos a lenguaje humano)

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

#[Route('/api/lookup')]
class LookupController extends AbstractController
{
    #[Route('/{table}/{field}', name: 'api_lookup', methods: ['GET'])]
    public function lookup(string $table, string $field, Connection $conn): JsonResponse
    {
        // 1️⃣ Busca en la tabla de metadatos cómo resolver esta relación
        $meta = $conn->fetchAssociative("
            SELECT tabla_referencia, campo_codigo_ref, campo_descripcion_ref
            FROM tb_mdp_codigo_relacion
            WHERE tabla_origen = ? AND campo_codigo = ?
            LIMIT 1
        ", [$table, $field]);

        if (!$meta) {
            return $this->json(['error' => 'No existe relación configurada'], 404);
        }

        // 2️⃣ Obtiene los valores del catálogo de referencia
        $rows = $conn->fetchAllAssociative("
            SELECT {$meta['campo_codigo_ref']} AS code, {$meta['campo_descripcion_ref']} AS label
            FROM {$meta['tabla_referencia']}
            ORDER BY {$meta['campo_descripcion_ref']}
        ");

        return $this->json($rows);
    }
}
