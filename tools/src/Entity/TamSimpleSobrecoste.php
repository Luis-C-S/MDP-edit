<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TamSimpleSobrecoste
{
    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $cod_sobrecoste;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $exceso_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $exceso_ampliado;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $exceso_peso_altura;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $coeficiente_ampliado;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'stringtype')]
    public ?mixed $fec_actualizacion;

}