<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTarifaria
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sap_destino;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}