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

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    // Devuelve todos los campos de la base de datos 'app'
    #[Route('/api/fields', name: 'api_fields', methods: ['GET'])]
    public function getFields(): JsonResponse
    {
        $fields = $this->connection->createQueryBuilder()
            ->select('COLUMN_NAME')
            ->from('INFORMATION_SCHEMA.COLUMNS')
            ->where('TABLE_SCHEMA = :db')
            ->setParameter('db', 'app') // nombre de tu base de datos
            ->executeQuery()
            ->fetchFirstColumn();

        return new JsonResponse($fields);
    }

    // Devuelve todas las tablas en las que está presente un campo
    #[Route('/api/tables/{field}', name: 'api_tables', methods: ['GET'])]
    public function getTables(string $field): JsonResponse
    {
        $tables = $this->connection->createQueryBuilder()
            ->select('TABLE_NAME')
            ->from('INFORMATION_SCHEMA.COLUMNS')
            ->where('TABLE_SCHEMA = :db')
            ->andWhere('COLUMN_NAME = :field')
            ->setParameter('db', 'app')
            ->setParameter('field', $field)
            ->executeQuery()
            ->fetchFirstColumn();

        return new JsonResponse($tables);
    }
}