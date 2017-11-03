FROM xataz/nginx-php

ARG SHAARLI_VERSION=0.9.2
ENV URL=shaarli.localdomain.tld

RUN apk -U add wget zip \
    && cd /tmp \
    && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin \
    && wget https://github.com/shaarli/Shaarli/releases/download/v$SHAARLI_VERSION/shaarli-v$SHAARLI_VERSION-full.zip \
    && unzip shaarli-v$SHAARLI_VERSION-full.zip \
    && mv Shaarli/ /shaarli \
    && wget https://github.com/kalvn/Shaarli-Material/archive/v$SHAARLI_VERSION.zip \
    && unzip v$SHAARLI_VERSION.zip \
    && mv Shaarli-Material-$SHAARLI_VERSION/material/ /shaarli/tpl/ \
    && cd /shaarli \
    && composer install \
    && chmod +w cache pagecache data tmp \
    && apk del wget zip \
    && rm -rf /tmp/* /var/cache/apk/* /usr/src/*

COPY rootfs /
VOLUME /shaarli/data /plugins
