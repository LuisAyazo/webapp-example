FROM php:7.2-apache
COPY . /var/www/html/
WORKDIR /var/www/html/

RUN apt-get update && \
    apt-get -y install git libz-dev libtidy-dev && \
    docker-php-ext-install tidy && \
    docker-php-ext-install zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# PHP Configuration required for PHP SDK
RUN touch /usr/local/etc/php/conf.d/memory.ini \
    && echo "memory_limit = 2048M;" >> /usr/local/etc/php/conf.d/memory.ini

RUN touch /usr/local/etc/php/conf.d/phar.ini \
    && echo "phar.readonly = Off;" >> /usr/local/etc/php/conf.d/phar.ini

RUN touch /usr/local/etc/php/conf.d/timezone.ini \
    && echo "date.timezone ='America/Bogota'" >> /usr/local/etc/php/conf.d/timezone.ini

RUN composer require aws/aws-sdk-php