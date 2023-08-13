# System zu Aktualisieren
sudo apt update -y
sudo apt upgrade -y

# Benötigte Pakete für die Installation
sudo apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y

# Paket Quelle für PHP
sudo curl -fsSL https://packages.sury.org/php/apt.gpg -o /usr/share/keyrings/php-archive-keyring.gpg
sudo echo "deb [signed-by=/usr/share/keyrings/php-archive-keyring.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

#Pakete Aktualisieren
sudo apt update -y

#Web-Server Installieren
sudo apt install apache2 -y

#PHP und die dazugehörige Module Installieren
sudo apt install php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-xml php8.2-xsl php8.2-zip php8.2-bz2 libapache2-mod-php8.2 -y

#MariaDB Server, sowie Client Installieren
sudo apt install mariadb-server mariadb-client -y

# Automate mysql_secure_installation
sudo mysql <<EOF
CREATE USER 'admin'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
EOF

#Verzeichnis wechseln für phpMyAdmin
cd /usr/share

#phpMyAdmin Installieren
sudo wget --no-check-certificate  https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip


#phpMyAdmin entpacken
sudo unzip phpmyadmin.zip

#Zip Datei Löschen
sudo rm phpmyadmin.zip

#Ordner namen zu phpmyadmin umbennen
sudo mv phpMyAdmin-*-all-languages phpmyadmin

#Berechtigung für phpMyAdmin erteilen
sudo chmod -R 0755 phpmyadmin

# Konfigurationsdatei Hinzufügen
echo "<?php
declare(strict_types=1);

\$cfg['blowfish_secret'] = ''; /* YOU MUST FILL IN THIS FOR COOKIE AUTH! */

\$i = 0;

\$i++;
\$cfg['Servers'][\$i]['auth_type'] = 'config';
\$cfg['Servers'][\$i]['host'] = 'localhost';
\$cfg['Servers'][\$i]['user'] = 'admin';
\$cfg['Servers'][\$i]['password'] = '';
\$cfg['Servers'][\$i]['AllowNoPassword'] = true;

\$cfg['UploadDir'] = '';
\$cfg['SaveDir'] = '';

?>" | sudo tee -a /usr/share/phpmyadmin/config.inc.php


#Konfigurationsdatei Hinzufügen
echo "Alias /phpmyadmin /usr/share/phpmyadmin

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
</Directory>" >> /etc/apache2/conf-available/phpmyadmin.conf

#phpMyAdmin Aktivieren
sudo a2enconf phpmyadmin

#Webserver reloaden
sudo systemctl reload apache2

#Temporär Verzeichnis für phpMyAdmin erstellen
sudo mkdir /usr/share/phpmyadmin/tmp/

#Web-Server Rechte erteilen für das Temporär Verzeichnis
sudo chown -R www-data:www-data /usr/share/phpmyadmin/tmp/
