#./build_prod.sh
#!/bin/bash

echo "🔧 Estableciendo entorno de producción..."
export APP_ENV=prod
echo "📦 Instalando dependencias sin paquetes de desarrollo..."
composer install --no-dev --optimize-autoloader

echo "🧹 Limpiando y calentando caché..."
php bin/console cache:clear --env=prod --no-debug
php bin/console cache:warmup --env=prod

echo "🧱 Compilando contenedor de servicios..."
php bin/console cache:clear --env=prod --no-debug

echo "🎨 Compilando assets (si usas Webpack Encore)..."
if [ -f "webpack.config.js" ]; then
  npm install
  npm run build
else
  echo "⚠️ Webpack Encore no detectado, omitiendo compilación de assets."
fi

echo "✅ Build de producción completada."
