FROM php:7.3-apache
ENV Koddownload_URL http://static.kodcloud.com/update/download/kodexplorer4.40.zip
##安装相关拓展
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        exiftool \
  && docker-php-ext-install -j$(nproc) iconv \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-install exif \
  && docker-php-ext-configure exif --enable-exif \
  && docker-php-ext-install pdo pdo_mysql \
  && cd /usr/local/bin && ./docker-php-ext-install mysqli \
  && rm -rf /var/cache/apk/*

##下载kodexplorer
RUN apt-get update && apt-get install -y --no-install-recommends unzip ca-certificates wget  \
    && wget -q -O /var/www/kodexplorer.zip ${Koddownload_URL} \
    && unzip -q /var/www/kodexplorer.zip -d /var/www/kodexplorer \ 
    && rm /var/www/kodexplorer.zip \
    && rm -rf /var/cache/apk/* && rm -rf /var/lib/apt/lists/* 

##挂载目录
VOLUME /var/www/html
##映射端口
EXPOSE 80
COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "php", "-S", "0000:80"]