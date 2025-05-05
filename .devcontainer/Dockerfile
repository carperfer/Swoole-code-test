FROM php:8.2-fpm

# Instalar dependencias de sistema y herramientas
RUN apt-get update && apt-get install -y \
    nginx supervisor git unzip libcurl4-openssl-dev pkg-config libssl-dev libpcre3-dev zlib1g-dev && \
    apt-get clean

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Instalar Swoole (vía PECL)
RUN pecl install swoole && docker-php-ext-enable swoole

# Crear carpetas para las apps
RUN mkdir -p /var/www/app /var/www/api

# Copiar código de las apps (los proveerás tú)
COPY ./app /var/www/app
COPY ./api /var/www/api

# Copiar config NGINX y Supervisor
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Copiar servidor swoole (lo vamos a crear ahora)
COPY app_server.php /var/www/app/server.php

# Configurar permisos
RUN chown -R www-data:www-data /var/www

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]