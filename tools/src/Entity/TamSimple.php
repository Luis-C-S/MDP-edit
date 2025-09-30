<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TamSimple
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $largo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $alto;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ancho;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $peso;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $logo_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}