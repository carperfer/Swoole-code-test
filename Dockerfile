FROM phpswoole/swoole:4.7-php7.4-alpine

RUN docker-php-ext-install mysqli pdo_mysql