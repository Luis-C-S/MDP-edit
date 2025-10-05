# MDP-edit
Github:
    git add .
    git commit -m "mensaje"
    git push

    git checkout Nombre_rama -> cambia a la rama indicada
    git reset --hard HEAD -> desecha los cambios desde el último commit

Docker: 
    Run `docker compose build --pull --no-cache` to build fresh images
    Run `docker compose up --wait` to set up and start a fresh Symfony project
    Open `https://localhost` in your favorite web browser and [accept the auto-generated TLS certificate](https://stackoverflow.com/a/15076602/1352334)
    Run `docker compose down --remove-orphans` to stop the Docker containers.

Bash:
    Entrar en el bash -> docker exec -it <contenedor> bash
    LLamar script desde el bash -> ./function.sh
    copiar script desde local al contenedor -> chmod +x function.sh
                                                ./function.sh
    
Hacer Functions:
    function <nombre> {código}

## Hay funciones personalizadas en $profile, se abre en  powershell con "code $profile":
## Si no se guardan en $profile, solo duran durante la sesión.
    bbdd -> Entrar al contendor mdp-edit-mysql-1
    app -> Entrar al contenedor mdp-edit-symfony-1
    pnpmyadmin -> Abre phpmyadmin en el navegador
    
    creartablas       ##Estas 4 funciones admiten nombres de tabla como argumento. Ej: "creartablas atributo_va producto_idioma ...". Sin argumento -> afecta a todas.
    borrartablas
    rellenartablas
    vaciartablas

Crear entidades para Doctrine con este script (dentro del contenedor de la app):
    php tools/generate_entities.php

