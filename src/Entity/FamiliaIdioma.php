<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class FamiliaIdioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_familia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_familia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_familia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $mas_info;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}