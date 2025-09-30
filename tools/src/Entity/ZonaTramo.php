<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTramo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_tramo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_tramo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $importe_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $por_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}