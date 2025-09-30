<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Prefijo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_prod_prefijo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_prefijo;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}