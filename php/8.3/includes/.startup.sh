#!/bin/bash

# Inserts the fresh user cronjobs into crontab
crontab /var/crons/crons

# start cron in the background
cron -f &

# php-fpm must be started in the foreground
php-fpm
