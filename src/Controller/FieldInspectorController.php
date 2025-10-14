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
        $this->schema = 'mdp_products'; // el esquema que quieres usar
        // Forzar search_path para esta conexión
        $this->connection->executeQuery('SET search_path TO mdp_products,public');
    }

    // Devuelve todos los campos del esquema
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

        // Eliminar duplicados y ordenar alfabéticamente
        $uniqueSortedFields = array_unique($fields);
        sort($uniqueSortedFields, SORT_NATURAL | SORT_FLAG_CASE);

        return new JsonResponse($uniqueSortedFields);
    }

    // Devuelve todas las tablas donde aparece un campo
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
}
