#!/bin/bash
set -e

if [[ "x"$PHPFPM_USER != "x" ]]; then
  usermod -u $PHPFPM_USER www-data
  groupmod -g $PHPFPM_USER www-data
fi

if [[ "x"$PHPFPM_CRON != "x" ]]; then
  gosu www-data env | sed 's/^\(.*\)\=\(.*\)$/export \1\="\2"/g' > /var/www/.cron_profile
  gosu www-data echo "* * * * * bash -l -c '. /var/www/.cron_profile;cd /var/www/magento && php bin/magento cron:run'" > cronfile
  gosu www-data crontab cronfile
  rm -f cronfile
  cron & exec "$@"
else
  exec "$@"
fi
