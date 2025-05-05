#!/bin/bash

# Lanzar PHP-FPM
php-fpm &

# Lanzar NGINX en foreground
nginx -g "daemon off;"