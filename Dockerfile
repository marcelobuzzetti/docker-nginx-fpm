FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add bash
RUN apk add nginx
RUN apk add php81 php81-fpm php81-opcache
RUN apk add php81-gd php81-zlib php81-curl 
RUN apk add musl php81-fileinfo php81-gettext php81-mbstring php81-openssl php81-pdo php81-pecl-psr php81-session php81-mysqli php81-pdo_mysql php81-pdo_dblib
#RUN apk add php81-pecl-phalcon

COPY server/etc/nginx /etc/nginx
COPY server/etc/php /etc/php81
COPY src /usr/share/nginx/html
RUN mkdir /var/run/php
EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["/bin/bash", "-c", "php-fpm81 && chmod 777 /var/run/php/php8-fpm.sock && chmod 755 /usr/share/nginx/html/* && nginx -g 'daemon off;'"]
#CMD ["/bin/bash", "-c", "php-fpm81 && nginx -g 'daemon off;'"]