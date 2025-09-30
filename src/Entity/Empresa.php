<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Empresa
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_empresa;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_empresa;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}