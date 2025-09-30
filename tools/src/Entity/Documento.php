<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Documento
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_documento;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $ind_validacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}