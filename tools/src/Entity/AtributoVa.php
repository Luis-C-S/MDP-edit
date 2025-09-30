<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class AtributoVa
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_atributo_va;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tipo_atributo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $tam_atributo;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}