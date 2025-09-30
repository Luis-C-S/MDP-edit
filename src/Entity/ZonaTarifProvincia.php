<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTarifProvincia
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_provincia_origen;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_provincia_destino;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}