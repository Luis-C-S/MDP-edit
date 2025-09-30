<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTramo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tramo;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_tramo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $por_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}