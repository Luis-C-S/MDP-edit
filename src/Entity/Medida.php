<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Medida
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_medida;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_medida;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}