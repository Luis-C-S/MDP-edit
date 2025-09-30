<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TamSimpleIdioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_tam;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_alto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_ancho;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_largo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_peso;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}