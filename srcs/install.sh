service nginx start
service mysql start
service php7.3-fpm start

#PHPMYADMIN

wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
mkdir /var/www/html/phpmyadmin
tar -xvf phpMyAdmin-5.0.4-english.tar.gz > /dev/null
mv phpMyAdmin-5.0.4-english/* /var/www/html/phpmyadmin
rm -rf phpMyAdmin-5.0.4-english.tar.gz
rm -rf phpMyAdmin-5.0.4-english
mv config.inc.php /var/www/html/phpmyadmin

#WORDPRESS

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz > /dev/null
rm latest.tar.gz
mv wordpress /var/www/html
mv wp-config.php /var/www/html/wordpress
cd /var/www/html/wordpress
sed -i 's/MYSQL_USER/'${MYSQL_USER}'/g' wp-config.php
sed -i 's/MYSQL_PWD/'${MYSQL_PWD}'/g' wp-config.php
cd ../../../..

#MYSQL

mysql -u root -e "CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PWD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE wordpress;"

#SSL

openssl req -x509 -nodes -newkey rsa:4096 -keyout cle.key -out cert.pem -days 365 -subj "/C=FR/CN=42Lyon" 
openssl x509 -outform pem -in cert.pem -out cert.crt
mv cert.crt /etc/nginx/
mv cle.key /etc/nginx/

#NGINX
cp /default_aion etc/nginx/sites-enabled/default
rm /var/www/html/index.html
mv /var/www/html/index.nginx-debian.html /var/www/html/index.html

service nginx restart
bash
