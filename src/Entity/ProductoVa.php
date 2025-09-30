<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoVa
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto_comercial;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_modalidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_pais;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_obligatorio;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_grp_va_obligatorio;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tipo_emb;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $num_intentos_entrega_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $num_intentos_entrega_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tiempo_lista_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tiempo_lista_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $tiempo_custodia;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_envio;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}