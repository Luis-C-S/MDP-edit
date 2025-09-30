<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoPerfilModalidad
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_sap;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_upu;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_obliga_cb;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $num_intentos_entrega;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $num_bultos_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $logo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_obliga_medidas;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $largo_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $largo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $largo_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ancho_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ancho_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ancho_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $alto_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $alto_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $alto_extra_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $criterio_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $criterio_extra;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $dimension_rollo_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $dimension_rollo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $diametro_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $diametro_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $criterio_rollo_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $peso_volumetrico_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $volumen;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $caducidad_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $caducidad_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tiempo_lista;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}