<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class AmbitoDetalle
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_ambito_detalle;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_ambito;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_provincia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}