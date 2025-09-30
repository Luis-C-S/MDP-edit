<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Modalidad
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_entrega;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_admision;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}