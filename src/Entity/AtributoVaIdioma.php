<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class AtributoVaIdioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_atributo_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_atributo_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}