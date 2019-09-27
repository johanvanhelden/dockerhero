#!/bin/bash

echo '---------------------------------------------'
echo 'Starting Xdebug';
echo '---------------------------------------------'

# Command to uncomment line with xdebug extension, therefor, enabling it
ON_CMD_PHP="sed -i 's/^;zend_extension=/zend_extension=/g' \
/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"

ON_CMD_WORKSPACE="sed -i 's/^;zend_extension=/zend_extension=/g' \
/etc/php/7.2/cli/conf.d/20-xdebug.ini"

echo '---------------------------------------------'
echo 'PHP:'
echo '---------------------------------------------'

docker exec -it dockerhero_php bash -c "${ON_CMD_PHP}"
docker restart dockerhero_php
docker exec -it dockerhero_php bash -c 'php -v'

echo '---------------------------------------------'
echo 'Workspace:'
echo '---------------------------------------------'

docker exec -it dockerhero_workspace bash -c "${ON_CMD_WORKSPACE}"
docker restart dockerhero_workspace
docker exec -it dockerhero_workspace bash -c 'php -v'
