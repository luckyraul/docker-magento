FROM luckyraul/php:7.2-full

MAINTAINER Nikita Tarasov <nikita@mygento.ru>

RUN apt-get -qq update && apt-get -qqy install gosu gettext-base && apt-get clean && \
    mkdir -p /var/www/magento/app/etc && \
    chown -R www-data:www-data /var/www/magento

ENV THEME_LANG=en_US

ARG AUTH='{}'

ADD composer.json /var/www/magento/composer.json
ADD composer.lock /var/www/magento/composer.lock
ADD app/etc/config.php /var/www/magento/app/etc/config.php

RUN chown www-data:www-data -R /var/www/magento && \
    gosu www-data echo "$AUTH" >> /var/www/magento/auth.json && \
    cd /var/www/magento && gosu www-data composer install --no-dev --prefer-dist --no-interaction && \
    rm -f /var/www/magento/auth.json

WORKDIR /var/www/magento

ONBUILD ARG AUTH='{}'
ONBUILD ADD composer.json /var/www/magento/composer.json
ONBUILD ADD composer.lock /var/www/magento/composer.lock
ONBUILD ADD app/etc/config.php /var/www/magento/app/etc/config.php
ONBUILD RUN gosu www-data echo "$AUTH" >> /var/www/magento/auth.json && \
            cd /var/www/magento && \
            gosu www-data composer install --no-dev --prefer-dist --no-interaction && \
            rm -f /var/www/magento/auth.json && \
            chown -R www-data:www-data /var/www/magento
ONBUILD RUN cd /var/www/magento && gosu www-data php bin/magento setup:di:compile -q
ONBUILD RUN cd /var/www/magento && gosu www-data php bin/magento setup:stat:deploy -f $THEME_LANG -q
