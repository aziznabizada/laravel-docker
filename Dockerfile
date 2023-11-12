FROM php:8.2.11-apache

WORKDIR /var/www/html


# mode Rewrite
RUN a2enmod rewrite 

# Install dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libmariadb-dev \
    unzip \
    zip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    zlib1g-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Install PostgreSQL and its PHP extension
# RUN apt-get install -y postgresql postgresql-contrib libpq-dev \
#     && docker-php-ext-install pdo_pgsql pgsql gd

# PHP extension
RUN docker-php-ext-install gettext intl pdo_mysql gd


RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd




