<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ImpuestoGravamen
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tasa_impositiva;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tipo_impuesto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tipo_gravamen;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $por_gravamen;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sap;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_inicio;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_fin;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}