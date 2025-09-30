<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Complemento
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_complemento;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}