<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Familia
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_familia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $logo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_familia_padre;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}