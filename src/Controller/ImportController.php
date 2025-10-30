<?php

namespace App\Controller;
//src/Controller/ImportController.php

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Doctrine\DBAL\Connection;

class ImportController extends AbstractController
{
    #[Route('/api/import/{tabla}', methods: ['POST'])]
    public function import(string $tabla, Request $request, Connection $conn): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $insertados = 0;
        $errores = [];

        if (!is_array($data)) {
            return new JsonResponse([
                'status' => 'error',
                'mensaje' => 'Formato JSON inválido',
            ], 400);
        }

        foreach ($data as $index => $row) {
            try {
                // Conversión de fechas si están en formato dd/mm/yyyy hh:mm
                foreach ($row as $key => $value) {
                    if (preg_match('/^\\d{2}\\/\\d{2}\\/\\d{4} \\d{1,2}:\\d{2}$/', $value)) {
                        $dt = \DateTime::createFromFormat('d/m/Y H:i', $value);
                        if ($dt) {
                            $row[$key] = $dt->format('Y-m-d H:i:s');
                        }
                    }
                }

                // Inserta en el esquema mdp_products
                $conn->insert("mdp_products.$tabla", $row);
                $insertados++;
            } catch (\Exception $e) {
                $errores[] = [
                    'fila' => $index + 1,
                    'error' => $e->getMessage(),
                    'datos' => $row,
                ];
            }
        }

        return new JsonResponse([
            'status' => 'ok',
            'tabla' => "mdp_products.$tabla",
            'insertados' => $insertados,
            'errores' => $errores,
        ]);
    }
}