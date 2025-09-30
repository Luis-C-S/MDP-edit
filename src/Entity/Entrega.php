<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Entrega
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_entrega;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_citypaq;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}