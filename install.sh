#!/bin/bash

echo "Enter your domain name:"
read domain

IFS="." read -r -a array <<<"$domain"

name="${array[0]}"
name_underscored=$(echo ${array[0]} | sed 's/-/_/g')

echo "Setting up environment"
touch .env

printf "COMPOSE_PROJECT_NAME=${name_underscored}\n" >>.env
printf "DB_USER=${name_underscored}\n" >>.env
printf "DB_PASS=%s\n" $(openssl rand -base64 24) >>.env
printf "XDEBUG_HOST=\n" >>.env

echo "Updating nginx config"
sed -i "s/SERVER_NAME/${name}/g" ./.docker/site.conf

echo "Creating and starting docker containers"
docker-compose up -d

echo "Installing WordPress"

echo "Enter your site title:"
read site_title

echo "Enter your admin username:"
read admin_user

echo "Enter your admin email:"
read admin_email

echo "Installing WordPress"
docker-compose run --rm wp-cli wp core install --url="${name}.localhost" --title="${site_title}" --admin_user="${admin_user}" --admin_email="${admin_email}"

echo "Installing plugins"
docker-compose run --rm wp-cli wp plugin delete hello akismet
docker-compose run --rm wp-cli wp plugin install classic-editor query-monitor disable-comments custom-post-type-ui seo-by-rank-math wp-mail-smtp --activate

echo "Script execution completed"
