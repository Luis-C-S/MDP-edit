<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoPerfilModalidad
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sap;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_upu;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_obliga_cb;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $num_intentos_entrega;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $num_bultos_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $logo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_obliga_medidas;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $largo_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $largo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $largo_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ancho_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ancho_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ancho_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $alto_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $alto_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $alto_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $criterio_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $criterio_extra;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $dimension_rollo_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $dimension_rollo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $diametro_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $diametro_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $criterio_rollo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $peso_volumetrico_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $volumen;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $caducidad_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $caducidad_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tiempo_lista;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}