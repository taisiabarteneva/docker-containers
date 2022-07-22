#!/bin/sh

# comment bind-address parameter
sed -i 's/^bind-address/#&/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s/\#port/port/"      /etc/mysql/mariadb.conf.d/50-server.cnf

chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/wordpress" ] ; then

mysql_install_db --user=mysql --datadir=/var/lib/mysql

# set root option so that connexion without root password is not possible
/usr/bin/mysql_secure_installation << EOF

y
superroot
superroot
y
n
y
y
EOF

service mysql start
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE_NAME;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE_NAME.* TO '$MYSQL_USER'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysqladmin -u root password $MYSQL_ROOT_PASSWORD
service mysql stop 

else 

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
chmod 777 /var/run/mysqld
touch /var/run/mysqld/mysqld.pid
rm -f /var/run/mysqld/mysqld.sock
mkfifo /var/run/mysqld/mysqld.sock
chmod 644 /var/run/mysqld/mysqld.sock

fi

chown -R mysql /var/run/mysqld

exec "$@"