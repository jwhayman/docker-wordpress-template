#!/bin/sh
# vim:sw=4:ts=4:et

set -e

# Generate SSL certificates
if [ ! -f /etc/ssl/localhost.crt ]
then
  echo "Generating SSL Certificate for ${NGINX_HOST}"
  openssl req -x509 -out localhost.crt -keyout localhost.key \
    -newkey rsa:2048 -nodes -sha256 \
    -subj "/CN=${NGINX_HOST}" -extensions EXT -config <( \
     printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
  mv localhost.crt /etc/ssl
  mv localhost.key /etc/ssl
fi
