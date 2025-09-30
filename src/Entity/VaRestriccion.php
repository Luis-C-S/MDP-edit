<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class VaRestriccion
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_va_rest;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}