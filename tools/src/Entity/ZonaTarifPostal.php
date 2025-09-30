<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class ZonaTarifPostal
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_zona_tarif;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_postal_origen;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_postal_destino;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}