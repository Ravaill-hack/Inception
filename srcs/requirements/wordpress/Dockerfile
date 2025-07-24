FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
						wget \
						curl \
						php7.4 \
						php7.4-fpm \
						php7.4-mysql \
						unzip \
						mariadb-client \
						less \
						netcat && \
	rm -rf /var/lib/apt/lists/* && \
	mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.8.2-fr_FR.tar.gz && rm wordpress-6.8.2-fr_FR.tar.gz && \
	chown -R root:root /var/www/wordpress

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/setup.sh /setup.sh

RUN chmod +x /setup.sh

WORKDIR /var/www/wordpress

ENTRYPOINT ["/setup.sh"]