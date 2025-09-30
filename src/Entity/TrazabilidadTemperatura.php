<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TrazabilidadTemperatura
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_trazabilidad_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_trazabilidad_temperatura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_datalogger;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}