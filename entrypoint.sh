#!/bin/bash
set -eu

if [ ! -e '/var/www/html/index.php' ]; then
    cp -a /var/www/kodexplorer/* /var/www/html/
fi
    chmod -R 777 /var/www/html/

exec "$@"