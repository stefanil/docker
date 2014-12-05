pt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

service mysql start &
sleep 5

echo "UPDATE mysql.user SET password=PASSWORD('rootpass') WHERE user='root'" | mysql
echo "CREATE DATABASE owncloud" | mysql
echo "GRANT ALL ON owncloud.* TO 'owncloud'@'%' IDENTIFIED BY 'devpass'" | mysql

sleep 5
service mysql stop
