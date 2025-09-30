<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoIdioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_producto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_producto_ext;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_factura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}