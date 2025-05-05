#!/bin/bash

# Lanza Swoole
php ./swoole/index.php &

# Lanzar PHP-FPM
php-fpm &

# Lanzar NGINX en foreground
nginx -g "daemon off;"