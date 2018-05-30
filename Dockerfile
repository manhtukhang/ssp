FROM php:7-apache

MAINTAINER MT <tu.khang@tiki.vn>

ENV SSP_VERSION 1.2
ENV SSP_URL https://github.com/ltb-project/self-service-password/archive/v${SSP_VERSION}.tar.gz

# Install the software that ssp environment requires
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && apt-get install -y libmcrypt-dev libldap2-dev sendmail --no-install-recommends \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install mbstring ldap \
    && echo TLS_REQCERT allow > /etc/ldap/ldap.conf \
    && rm -rf /var/lib/apt/lists/*

# Install ssp from github
RUN cd /var/www/ && \
        curl -SL $SSP_URL | tar -xz -C /var/www/ && \
        mv self-service-password-${SSP_VERSION} html/ssp && \
        rm -rf self-service-password-${SSP_VERSION}
#COPY assets/favicon.ico /var/www/html/ssp/images/favicon.ico
COPY assets/entrypoint.sh /entrypoint.sh
COPY assets/ssp-site-apache.conf /etc/apache2/sites-available/ssp.conf
RUN chmod +x /entrypoint.sh

#VOLUME /var/www/html

EXPOSE 80

ENTRYPOINT /entrypoint.sh



