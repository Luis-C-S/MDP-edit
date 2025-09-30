<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class VaPerfil
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_perfil;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sap;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_base;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $importe_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $por_incremento;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $valor_complejidad;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_precio_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_formula;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $desc_formula;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}