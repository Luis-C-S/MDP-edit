FROM shinsenter/symfony:latest

# Instalar Node.js, npm y Yarn
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn \
    && apt-get clean

# Verificar versiones
RUN node -v && npm -v && yarn -v