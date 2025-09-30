<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Documento
{
    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $cod_documento;

    #[\Doctrine\ORM\Mapping\Column(type: 'string')]
    public ?string $ind_validacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_creacion;

    #[\Doctrine\ORM\Mapping\Column(type: 'datetime')]
    public ?\DateTimeInterface $fec_actualizacion;

}