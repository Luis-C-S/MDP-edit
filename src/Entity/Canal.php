<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Canal
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_canal;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_canal;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}