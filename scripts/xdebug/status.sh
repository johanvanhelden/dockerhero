#!/bin/bash

echo '---------------------------------------------'
echo 'Xdebug status';
echo '---------------------------------------------'

echo '---------------------------------------------'
echo 'PHP:'
echo '---------------------------------------------'
docker exec -it dockerhero_php bash -c 'php -v'

echo '---------------------------------------------'
echo 'Workspace:'
echo '---------------------------------------------'
docker exec -it dockerhero_workspace bash -c 'php -v'
