<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoSistemaPrefijo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_prod_prefijo;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sistema;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_valor_declarado;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_entrega_recogida;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}