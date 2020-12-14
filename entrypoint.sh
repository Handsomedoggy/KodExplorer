#!/bin/bash
set -eu

if [ ! -e '/var/www/html/index.php' ]; then
    cp -a /var/www/kodexplorer/* /var/www/html/
fi
    chown -R www-data /var/www/html
    chgrp -R www-data /var/www/html
    chmod -R 777 /var/www/html/

exec "$@"