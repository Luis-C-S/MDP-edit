<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class FranjaHoraria
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_franja;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $hora_inicio;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $hora_fin;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}