<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Idioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_idioma;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_ref;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idi_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}