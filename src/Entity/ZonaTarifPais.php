<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTarifPais
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_bloqueado;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_pais_origen;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}