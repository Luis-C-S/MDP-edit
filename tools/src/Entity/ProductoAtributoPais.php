<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoAtributoPais
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_obliga_peso;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $peso_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $peso_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}