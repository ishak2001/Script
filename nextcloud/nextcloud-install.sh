#!/bin/bash

# Passwortabfragen
read -sp 'Geben Sie das MySQL admin-Passwort ein: ' ADMIN_PW
echo
read -sp 'Geben Sie das Nextcloud admin-Passwort ein: ' NEXTCLOUD_ADMIN_PW
echo

# System aktualisieren
apt update
apt upgrade -y

# Notwendige Pakete installieren
apt install -y ca-certificates apt-transport-https lsb-release gnupg curl nano unzip

# Sury PHP Repository hinzufügen
curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Paketlisten aktualisieren
apt update

# Apache und PHP 8.1 installieren
apt install -y apache2
apt install -y php8.1 php8.1-cli php8.1-common php8.1-curl php8.1-gd php8.1-intl php8.1-mbstring php8.1-mysql php8.1-opcache php8.1-readline php8.1-xml php8.1-xsl php8.1-zip php8.1-bz2 libapache2-mod-php8.1

# MariaDB installieren
apt install -y mariadb-server mariadb-client

# phpMyAdmin herunterladen und einrichten
cd /usr/share
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip
unzip phpmyadmin.zip
rm phpmyadmin.zip
mv phpMyAdmin-*-all-languages phpmyadmin
chmod -R 0755 phpmyadmin

# phpMyAdmin Apache Konfiguration erstellen
echo "# phpMyAdmin Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
</Directory>

# Disallow web access to directories that don't need it
<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>" > /etc/apache2/conf-available/phpmyadmin.conf

# Konfiguration aktivieren und Apache neu laden
a2enconf phpmyadmin
systemctl reload apache2

# MySQL admin-Passwort setzen
mysqladmin -u admin password "$ADMIN_PW"

# Nextcloud herunterladen und einrichten
cd /var/www/html
wget https://download.nextcloud.com/server/releases/nextcloud-25.0.4.zip -O nextcloud.zip
unzip nextcloud.zip
rm nextcloud.zip
chown -R www-data:www-data /var/www/html/nextcloud
chmod -R 755 nextcloud

# Nextcloud benutzer und Datenbank anlegen
mysql -u admin -p"$ADMIN_PW" <<EOF
DROP USER IF EXISTS 'nextcloud'@'localhost';
CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY '$NEXTCLOUD_ADMIN_PW';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost';
FLUSH PRIVILEGES;
EOF

# Nextcloud Konfiguration erstellen
cat <<EOL > /var/www/html/nextcloud/config/autoconfig.php
<?php
\$AUTOCONFIG = array(
  "dbtype"        => "mysql",
  "dbname"        => "nextcloud",
  "dbuser"        => "admin",
  "dbpass"        => "$ADMIN_PW",
  "dbhost"        => "localhost",
  "dbtableprefix" => "",
  "adminlogin"    => "admin",
  "adminpass"     => "$NEXTCLOUD_ADMIN_PW",
  "directory"     => "/var/www/html/nextcloud/data",
);
EOL

# Apache Konfiguration aktivieren und neu laden
a2enmod rewrite headers env dir mime setenvif
systemctl reload apache2
