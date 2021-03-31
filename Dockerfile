#FROM alpine:3.10
FROM php:7.2.30-fpm-alpine3.11

RUN set -x \
    && echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories \
    && apk update \
    && apk add nginx  \
    && apk add curl bash \
    && apk add libpng-dev icu-dev gmp-dev \
	&& docker-php-ext-install -j$(nproc) mysqli pdo_mysql gd intl opcache bcmath zip pcntl gmp \
    && mkdir /run/nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY run.sh /run.sh
COPY index.php /var/www/index.php

# 若使用root权限启动nginx, 开启gzip压缩, 需修改配置如下
RUN sed 's/user nginx;/user root;/g' /etc/nginx/nginx.conf | sed 's/#gzip on;/gzip on;/g' > /tmp/nginx.conf
RUN mv /tmp/nginx.conf /etc/nginx/nginx.conf

# 开启opcache
RUN sed 's/;opcache.enable=1/opcache.enable=1/g' /etc/php7/php.ini | sed 's/;opcache.validate_timestamps=1/opcache.validate_timestamps=0/g' | sed 's/;opcache.memory_consumption=128/opcache.memory_consumption=128/g' | sed 's/;opcache.interned_strings_buffer=8/opcache.interned_strings_buffer=8/g' | sed 's/;opcache.max_accelerated_files=10000/opcache.max_accelerated_files=10000/g' > /tmp/php.ini
RUN mv /tmp/php.ini /etc/php7/php.ini

VOLUME /var/www

EXPOSE 80 443

CMD ["/run.sh"]