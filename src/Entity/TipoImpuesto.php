<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TipoImpuesto
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tipo_impuesto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_tipo_impuesto;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}