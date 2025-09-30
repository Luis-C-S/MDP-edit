<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ProductoAtributo
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_producto;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_alta;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_baja;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $num_digitos_cb;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $observ_cb;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $paginas_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $palabras_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_log_inversa;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_empresa;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_exento_aduana;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_spu;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ent_orientativa_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ent_orientativa_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ent_comprometidos_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ent_comprometidos_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $retraso_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $retraso_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $retraso_indemnizacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $deterioro_min;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $deterioro_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $deterioro_indemnizacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $plazo_respuesta_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $plazo_indemniza_max;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $fec_actualizacion;

}