<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Tramo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tramo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $limite_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $limite_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_medida;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}