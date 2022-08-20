FROM nginx:1.23-alpine

# Install OpenSSL
RUN apk update \
    && apk --no-cache add openssl

COPY 40-setup-ssl-certificates.sh /docker-entrypoint.d