<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class RangoTemperatura
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_rango_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_rango_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $temperatura_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $temperatura_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}