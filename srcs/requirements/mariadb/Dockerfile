FROM debian:buster

RUN apt update && apt install -y mariadb-server; \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY ./tools/mariadb-setup.sh   /usr/bin/

RUN chmod +x /usr/bin/mariadb-setup.sh

ENTRYPOINT [ "/usr/bin/mariadb-setup.sh" ]

# restarting the server when an error occurs and logging runtime information to an error log
CMD [ "mysqld_safe" ]