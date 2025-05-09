FROM php:7.4.2-fpm

RUN apt-get update && apt-get install vim -y && \
    apt-get install openssl -y && \
    apt-get install libssl-dev -y && \
    apt-get install wget -y && \
    apt-get install git -y && \
    apt-get install procps -y && \
    apt-get install htop -y && \
    apt-get install nginx supervisor git unzip libcurl4-openssl-dev pkg-config libssl-dev libpcre3-dev zlib1g-dev -y

RUN cd /tmp && git clone https://github.com/swoole/swoole-src.git && \
    cd swoole-src && \
    git checkout v4.5.2 && \
    phpize  && \
    ./configure  --enable-openssl && \
    make && make install

RUN touch /usr/local/etc/php/conf.d/swoole.ini && \
    echo 'extension=swoole.so' > /usr/local/etc/php/conf.d/swoole.ini

RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

# Crear carpetas para las apps
RUN mkdir -p /var/www/app /var/www/api

# Copiar código de las apps (los proveerás tú)
COPY ./app /var/www/app
COPY ./api /var/www/api

# Copiar config NGINX y Supervisor
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisor/supervisord.conf

# Copiar servidor swoole (lo vamos a crear ahora)
# COPY ../app/server.php /var/www/app/server.php

# Configurar permisos
RUN chown -R www-data:www-data /var/www

EXPOSE 80

# ENTRYPOINT ["php", "index.php"]
# ENTRYPOINT ["/usr/local/bin/dumb-init", "--", "php"]
CMD ["sh", "start.sh"]