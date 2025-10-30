<?php
// src/Controller/InfoProductoController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\ArrayParameterType;

class InfoProductoController extends AbstractController
{
    private Connection $connection;

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
        $this->connection->executeQuery('SET search_path TO mdp_products,public');
    }

    #[Route('/api/producto', name: 'api_producto', methods: ['GET'])]
    public function getProductos(): JsonResponse
    {
        $productos = $this->connection->createQueryBuilder()
            ->select('cod_producto', 'nom_producto')
            ->from('mdp_products.tb_mdp_producto') // esquema explícito
            ->fetchAllAssociative();

        $options = array_map(fn($p) => [
            'value' => $p['cod_producto'],
            'label' => $p['nom_producto']
        ], $productos);

        return new JsonResponse($options);
    }

    #[Route('/api/perfil/{cod_producto}', name: 'api_perfil_por_producto', methods: ['GET'])]
    public function getPerfilesPorProducto(string $cod_producto): JsonResponse
    {
        // 1. Obtener cod_perfil asociados al producto
        $perfilIds = $this->connection->createQueryBuilder()
            ->select('cod_perfil')
            ->from('mdp_products.tb_mdp_producto_perfil')
            ->where('cod_producto = :cod_producto')
            ->setParameter('cod_producto', $cod_producto)
            ->fetchFirstColumn();

        if (empty($perfilIds)) {
            return new JsonResponse([]);
        }

        // 2. Obtener nom_perfil desde tb_mdp_perfil
        $perfiles = $this->connection->createQueryBuilder()
            ->select('cod_perfil', 'nom_perfil')
            ->from('mdp_products.tb_mdp_perfil')
            ->where('cod_perfil IN (:ids)')
            ->setParameter('ids', $perfilIds, ArrayParameterType::STRING)
            ->fetchAllAssociative();

        $options = array_map(fn($p) => [
            'value' => $p['cod_perfil'],
            'label' => $p['nom_perfil']
        ], $perfiles);

        return new JsonResponse($options);
    }

    #[Route('/api/modalidad/{cod_producto}/{cod_perfil}', name: 'api_modalidad_por_producto_perfil', methods: ['GET'])]
    public function getModalidadesPorProductoYPerfil(string $cod_producto, string $cod_perfil): JsonResponse
    {
        $cod_producto_comercial = $cod_producto . $cod_perfil;

        // 1. Buscar cod_modalidad exactos para el producto comercial
        $modalidadIds = $this->connection->createQueryBuilder()
            ->select('DISTINCT cod_modalidad')
            ->from('mdp_products.tb_mdp_producto_perfil_modalidad')
            ->where('cod_producto_comercial = :comercial')
            ->setParameter('comercial', $cod_producto_comercial)
            ->fetchFirstColumn();

        if (empty($modalidadIds)) {
            return new JsonResponse([]);
        }

        // 2. Buscar nom_modalidad en idioma español
        $modalidades = $this->connection->createQueryBuilder()
            ->select('cod_modalidad', 'nom_modalidad')
            ->from('mdp_products.tb_mdp_modalidad_idioma')
            ->where('cod_modalidad IN (:ids)')
            ->andWhere('cod_idioma_alpha2 = :idioma')
            ->setParameter('ids', $modalidadIds, \Doctrine\DBAL\ArrayParameterType::STRING)
            ->setParameter('idioma', 'es')
            ->fetchAllAssociative();

        $options = array_map(fn($m) => [
            'value' => $m['cod_modalidad'],
            'label' => $m['nom_modalidad']
        ], $modalidades);

        return new JsonResponse($options);
    }
}
