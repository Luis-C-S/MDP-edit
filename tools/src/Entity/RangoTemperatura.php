<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class RangoTemperatura
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_rango_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $desc_rango_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $temperatura_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $temperatura_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}