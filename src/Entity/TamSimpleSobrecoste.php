<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class TamSimpleSobrecoste
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_tam_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_sobrecoste;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $exceso_simple;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $exceso_ampliado;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $exceso_peso_altura;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $coeficiente_ampliado;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}