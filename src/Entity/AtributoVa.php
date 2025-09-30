<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class AtributoVa
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_atributo_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tipo_atributo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tam_atributo;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}