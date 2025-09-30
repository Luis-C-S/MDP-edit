<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoAtributoPais
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_obliga_peso;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $peso_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $peso_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}