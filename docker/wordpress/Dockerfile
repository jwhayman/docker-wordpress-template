FROM wordpress:php8.1-fpm

# Setup PHP
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN pecl config-set php_ini "$PHP_INI_DIR/php.ini" \
    && pear config-set php_ini "$PHP_INI_DIR/php.ini"

# Install Xdebug
RUN apt-get update \
    && apt-get install -y ${PHPIZE_DEPS} \
    && pecl install xdebug-3.1.5 \
    && docker-php-ext-enable xdebug

# Install PHP Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && chown www-data:www-data composer.phar \
    && mv composer.phar /usr/local/bin/composer

ENV PATH="${PATH}:~/.composer/vendor/bin"

# Install Composer packages
RUN composer global require phpmailer/phpmailer \
    && composer global require wp-cli/wp-cli-bundle

RUN echo alias 'wp="wp --allow-root"' >> ~/.bashrc

# Install Maria DB client for WP-CLI
RUN apt-get install -y mariadb-client