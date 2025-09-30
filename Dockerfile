FROM shinsenter/symfony:latest

# Instalar Node.js y npm
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Verificar versiones
RUN node -v && npm -v
