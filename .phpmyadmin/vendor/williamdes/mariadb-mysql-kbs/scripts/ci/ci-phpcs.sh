#!/bin/bash
cd $(dirname $0)/../../
echo "Running in : $(pwd)"
./vendor/bin/phpcs --standard=phpcs.xml --no-cache --colors -p -n
