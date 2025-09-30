<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoIdioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $nom_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $desc_producto;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $desc_producto_ext;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $desc_factura;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}