<?php
// src/Controller/WorldMapController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\DBAL\Connection;

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
        $codAmbito = $request->query->get('cod_ambito');

        $sql = "
        SELECT DISTINCT z.cod_zona_tarif, a.nom_zona_tarif
        FROM mdp_products.tb_mdp_producto_zona z
        JOIN mdp_products.tb_mdp_zona_tarifaria a ON z.cod_zona_tarif = a.cod_zona_tarif
        WHERE z.cod_producto_comercial = :codProductoComercial
        AND z.cod_modalidad = :codModalidad
        AND z.cod_ambito = :codAmbito
    ";

        $result = $this->connection->fetchAllAssociative($sql, [
            'codProductoComercial' => $codProductoComercial,
            'codModalidad' => $codModalidad,
            'codAmbito' => $codAmbito,
        ]);

        return $this->json($result);
    }

    // Obtener países por zona tarifaria
    #[Route('/api/paises', name: 'api_paises')]
    public function obtenerPaises(Request $request): JsonResponse
    {
        $codZonaTarif = $request->query->get('cod_zona_tarif');
        $codProducto = $request->query->get('selectedProducto');
        $codPerfil = $request->query->get('selectedPerfil');
        $codModalidad = $request->query->get('selectedModalidad');
        $codAmbito = $request->query->get('selectedAmbito');
        $codProductoComercial = $codProducto . $codPerfil;

        if ($codZonaTarif) {
            // Comportamiento actual
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

        // Validar que los otros parámetros estén presentes
        if (!$codProducto || !$codPerfil || !$codModalidad || !$codAmbito) {
            return $this->json(['error' => 'Faltan parámetros necesarios'], 400);
        }

        // Obtener países y nombres de zonas tarifarias asociadas a los filtros
        $sql = "
        SELECT DISTINCT ztp.cod_pais, zt.nom_zona_tarif
        FROM mdp_products.tb_mdp_zona_tarifaria zt
        JOIN mdp_products.tb_mdp_zona_tarif_pais ztp ON zt.cod_zona_tarif = ztp.cod_zona_tarif
        JOIN mdp_products.tb_mdp_producto_zona pz ON zt.cod_zona_tarif = pz.cod_zona_tarif
        WHERE pz.cod_producto_comercial = :codProductoComercial
          AND pz.cod_modalidad = :codModalidad
          AND pz.cod_ambito = :codAmbito
    ";

        $result = $this->connection->fetchAllAssociative($sql, [
            'codProductoComercial' => $codProductoComercial,
            'codModalidad' => $codModalidad,
            'codAmbito' => $codAmbito,
        ]);

        return $this->json($result);
    }
}
