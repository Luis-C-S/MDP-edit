<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Ambito
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_ambito;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_ambito;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}