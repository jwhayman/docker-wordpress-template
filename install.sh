#!/bin/bash

echo "Initializing"

newdomain="$1"

IFS="." read -r -a array <<< "$newdomain"

name=`echo ${array[0]} | sed 's/-/_/g'`

echo "Setting up environment"
touch .env

printf "COMPOSE_PROJECT_NAME=${array[0]}\n" >> .env
printf "DB_USER=${name}\n" >> .env
printf "DB_PASS=%s\n" $(openssl rand -base64 24) >> .env

echo "Rewriting nginx config"
sed -i "s/SERVER_NAME/${array[0]}/g" ./.docker/site.conf

echo "Creating and starting docker containers"
docker-compose up -d

#echo "Installing WordPress"
#wp core install --path=/home/james/Development/"$newdomain"/site --url="${array[0]}.localhost" --title="$newdomain" --admin_user=WildPress --admin_email="james@wildpress.co"
#
#echo "Setting config constants"
#wp config set --path=/home/james/Development/"$newdomain"/site "FS_METHOD" "direct" --type=constant
#
#echo "Installing plugins"
#wp plugin install --path=/home/james/Development/"$newdomain"/site query-monitor --activate

echo "Script execution completed"
