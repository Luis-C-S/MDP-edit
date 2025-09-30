<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TipoMaterial
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tipo_material;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $nom_tipo_material;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}