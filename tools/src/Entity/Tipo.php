<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Tipo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_tipo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $nom_tipo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}