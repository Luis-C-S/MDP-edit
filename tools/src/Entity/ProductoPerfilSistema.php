<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoPerfilSistema
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_sistema;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cuenta_cont;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_inicio_destacado;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_fin_destacado;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}