FROM debian:buster

RUN apt update && apt -y install nginx openssl; \
    echo "daemon off;" >> /etc/nginx/nginx.conf; \
    rm -rf /var/lib/apt/lists/* 

COPY ./conf/nginx.conf      /etc/nginx/sites-available/default

EXPOSE 443

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 3650 -nodes \
    -out    /etc/ssl/wurrigon.42.fr.cert \
    -keyout /etc/ssl/wurrigon.42.fr.key \
    -subj "/C=RU/ST=Moscow/L=Moscow /O=21 School/OU=wurrigon/CN=wurrigon.42.fr/emailAddress=unknown"

CMD [ "nginx" ]