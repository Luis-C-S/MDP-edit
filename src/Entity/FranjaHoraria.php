<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class FranjaHoraria
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_franja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $hora_inicio;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $hora_fin;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}