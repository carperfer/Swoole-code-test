# Imagen base oficial con PHP-FPM + NGINX
FROM php:8.2-fpm

#Swoole
RUN apt-get update && apt-get install vim -y && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install wget -y && \
    apt-get install git -y && \
    apt-get install procps -y && \
    apt-get install htop -y

RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
    cd swoole-src && \
    git checkout v4.5.2 && \
    phpize  && \
    ./configure  --enable-openssl && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Instalar NGINX y herramientas necesarias
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Crear carpetas para las dos apps
RUN mkdir -p /var/www/app /var/www/api

# Copiar los archivos de las apps (asumimos que tienes app/ y api/ en el contexto build)
COPY ./clasicphp /var/www/app
COPY ./swoole /var/www/swoole

# Copiar configuración de NGINX
COPY ./nginx.conf /etc/nginx/nginx.conf

# Configurar permisos
RUN chown -R www-data:www-data /var/www

# Copiar configuración PHP (opcional, pero recomendado para producción)
COPY ./php.ini /usr/local/etc/php/

# Script de inicio: lanzar PHP-FPM y NGINX juntos
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80

CMD ["/start.sh"]

# ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "php"]