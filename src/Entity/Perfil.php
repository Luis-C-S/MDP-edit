<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Perfil
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_perfil;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_perfil;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_cliente_contrato;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_oferta_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}