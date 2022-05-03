FROM wordpress:php7.4-fpm

# Install Git
RUN apt-get update && \
    apt-get -y install git

# Clone xdebug and build from source
RUN cd /tmp && \
    git clone https://github.com/xdebug/xdebug.git && \
    cd xdebug && \
    git checkout xdebug_3_1 && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install && \
    rm -rf /tmp/xdebug

# Create xdebug.ini config file \
COPY .docker/wordpress /

# Enable xdebug
RUN docker-php-ext-enable xdebug