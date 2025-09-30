<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TamSimple
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $largo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $alto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ancho;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $peso;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $logo_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}