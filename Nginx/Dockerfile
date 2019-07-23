FROM luckyraul/nginx:backports

MAINTAINER Nikita Tarasov <nikita@mygento.ru>

RUN mkdir -p /var/www/magento/pub /var/www/magento/setup/pub && rm -f /etc/nginx/sites-enabled/default

USER www-data
WORKDIR /var/www/magento

COPY --from=luckyraul/magento:2.3 /var/www/magento/pub/static /var/www/magento/pub/static
COPY --from=luckyraul/magento:2.3 /var/www/magento/setup/pub /var/www/magento/setup/pub

USER root
