<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoSobrecoste
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sobrecoste;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_fijo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $por_sobrecoste;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}