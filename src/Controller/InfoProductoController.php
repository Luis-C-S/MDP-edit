<?php
// src/Controller/InfoProductoController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
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

    // 
    #[Route('/api/ambitos', name: 'api_ambitos')]
    public function obtenerAmbitos(Request $request, Connection $conn): JsonResponse
    {
        $codProductoComercial = $request->query->get('cod_producto_comercial');
        $codModalidad = $request->query->get('cod_modalidad');

        $sql = "
        SELECT DISTINCT z.cod_ambito, a.nom_ambito
        FROM mdp_products.tb_mdp_producto_zona z
        JOIN mdp_products.tb_mdp_ambito a ON z.cod_ambito = a.cod_ambito
        WHERE z.cod_producto_comercial = :codProductoComercial
        AND z.cod_modalidad = :codModalidad
    ";

        $result = $conn->fetchAllAssociative($sql, [
            'codProductoComercial' => $codProductoComercial,
            'codModalidad' => $codModalidad,
        ]);

        return $this->json($result);
    }

    #[Route('/api/precios', name: 'api_precios')]
    public function precios(Request $request, Connection $conn): JsonResponse
    {
        $producto = $request->query->get('producto');
        $perfil = $request->query->get('perfil');
        $modalidad = $request->query->get('modalidad');
        $ambito = $request->query->get('ambito');  

        if (!$producto || !$perfil || !$modalidad || !$ambito) {
            return $this->json(['error' => 'Faltan parámetros'], 400);
        }

        $codProductoComercial = $producto . $perfil;

        // Obtener cod_zona_tarif desde tb_mdp_producto_zona
        $zonasTarif = $conn->fetchFirstColumn("
        SELECT DISTINCT cod_zona_tarif
        FROM mdp_products.tb_mdp_producto_zona
        WHERE cod_producto_comercial = :codProductoComercial
          AND cod_modalidad = :codModalidad
          AND cod_ambito = :codAmbito
    ", [
            'codProductoComercial' => $codProductoComercial,
            'codModalidad' => $modalidad,
            'codAmbito' => $ambito,
        ]);

        if (empty($zonasTarif)) {
            return $this->json([]);
        }

        // Obtener precios desde tb_mdp_zona_tramo
        $datos = $conn->fetchAllAssociative("
        SELECT
            zt.cod_zona_tarif,
            zt.cod_tramo,
            zt.importe_tramo,
            tz.nom_zona_tarif,
            ti.nom_tramo
        FROM mdp_products.tb_mdp_zona_tramo zt
        JOIN mdp_products.tb_mdp_zona_tarifaria tz ON zt.cod_zona_tarif = tz.cod_zona_tarif
        JOIN mdp_products.tb_mdp_tramo_idioma ti ON zt.cod_tramo = ti.cod_tramo
        WHERE zt.cod_zona_tarif IN (:zonasTarif)
        ORDER BY zt.cod_tramo
    ", [
            'zonasTarif' => $zonasTarif,
        ], [
            'zonasTarif' => ArrayParameterType::STRING,
        ]);

        // 3. Formatear JSON
        $resultado = array_map(fn($row) => [
            'zona' => $row['nom_zona_tarif'],
            'peso' => $row['nom_tramo'],
            'precio' => (float) $row['importe_tramo'],
        ], $datos);

        return $this->json($resultado);
    }
}
