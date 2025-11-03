<?php
// src/Controller/WorldMapController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\ArrayParameterType;

class WorldMapController extends AbstractController
{
    private Connection $connection;

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
        $this->connection->executeQuery('SET search_path TO mdp_products,public');
    }


    // 
    #[Route('/api/zonas', name: 'api_zonas')]
    public function obtenerZonas(Request $request): JsonResponse
    {
        $codProductoComercial = $request->query->get('cod_producto_comercial');
        $codModalidad = $request->query->get('cod_modalidad');

        $sql = "
        SELECT DISTINCT z.cod_zona_tarif, a.nom_zona_tarif
        FROM mdp_products.tb_mdp_producto_zona z
        JOIN mdp_products.tb_mdp_zona_tarifaria a ON z.cod_zona_tarif = a.cod_zona_tarif
        WHERE z.cod_producto_comercial = :codProductoComercial
        AND z.cod_modalidad = :codModalidad
    ";

        $result = $this->connection->fetchAllAssociative($sql, [
            'codProductoComercial' => $codProductoComercial,
            'codModalidad' => $codModalidad,
        ]);

        return $this->json($result);
    }

    // Obtener países por zona tarifaria
    #[Route('/api/paises', name: 'api_paises')]
    public function obtenerPaises(Request $request): JsonResponse
    {
        $codZonaTarif = $request->query->get('cod_zona_tarif');

        if (!$codZonaTarif) {
            return $this->json(['error' => 'Falta el parámetro cod_zona_tarif'], 400);
        }

        $sql = "
            SELECT DISTINCT cod_pais
            FROM tb_mdp_zona_tarif_pais
            WHERE cod_zona_tarif = :codZonaTarif
        ";

        $result = $this->connection->fetchAllAssociative($sql, [
            'codZonaTarif' => $codZonaTarif,
        ]);

        return $this->json($result);
    }
}
