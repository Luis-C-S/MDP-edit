<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class AmbitoPerfilModalidad
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_ambito;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}