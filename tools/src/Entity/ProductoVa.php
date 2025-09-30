<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoVa
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_obligatorio;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_grp_va_obligatorio;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tipo_emb;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $num_intentos_entrega_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $num_intentos_entrega_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tiempo_lista_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tiempo_lista_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tiempo_custodia;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_envio;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}