<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class VaFranqueoPerfil
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_perfil;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_franqueo;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}