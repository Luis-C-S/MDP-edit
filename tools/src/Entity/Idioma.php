<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Idioma
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_idioma;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $nom_idioma;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_idioma_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_idioma_ref;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_idi_alpha2;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}