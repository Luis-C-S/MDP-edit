<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoTipo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tipo;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}