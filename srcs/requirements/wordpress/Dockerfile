FROM debian:buster

RUN apt update && apt -y install php7.3 php-mysql php-fpm mariadb-client; \
    rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y wget && \
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp; \
    apt remove -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN wp core download --path=/usr/src/wordpress --allow-root

RUN sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = wordpress:9000/" "/etc/php/7.3/fpm/pool.d/www.conf"

EXPOSE 9000

COPY ./tools/wp-setup.sh /

RUN chmod +x wp-setup.sh

ENTRYPOINT [ "./wp-setup.sh" ]