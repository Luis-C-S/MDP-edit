FROM shinsenter/symfony:latest

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y curl wget git ca-certificates

# Instalar NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Instalar Node.js 20 usando NVM
RUN bash -c "source $NVM_DIR/nvm.sh && nvm install 20 && nvm use 20 && nvm alias default 20"

# Añadir Node y NPM al PATH
ENV NODE_PATH=$NVM_DIR/versions/node/v20.*/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v20.*/bin:$PATH

# Instalar Yarn globalmente
RUN npm install -g yarn

# Verificar versiones
RUN bash -c "source $NVM_DIR/nvm.sh && node -v && npm -v && yarn -v"