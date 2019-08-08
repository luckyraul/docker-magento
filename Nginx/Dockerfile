FROM luckyraul/nginx:backports

MAINTAINER Nikita Tarasov <nikita@mygento.ru>

RUN mkdir -p /var/www/magento/pub/errors /var/www/magento/setup/pub && rm -f /etc/nginx/sites-enabled/default

COPY --from=luckyraul/magento:2.3 /var/www/magento/pub/static /var/www/magento/pub/static
COPY --from=luckyraul/magento:2.3 /var/www/magento/setup/pub /var/www/magento/setup/pub

RUN touch /var/www/magento/pub/index.php && \
    touch /var/www/magento/pub/get.php && \
    touch /var/www/magento/pub/static.php && \
    touch /var/www/magento/pub/health_check.php && \
    touch /var/www/magento/pub/errors/report.php && \
    touch /var/www/magento/pub/errors/404.php && \
    touch /var/www/magento/pub/errors/503.php && \
    touch /var/www/magento/setup/index.php && \
    chown www-data:www-data -R /var/www
