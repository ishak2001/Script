# System zu Aktualisieren
apt update -y
apt upgrade -y

# Benötigte Pakete für die Installation
apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y

apt install ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install docker-ce docker-ce-cli containerd.io -y

apt update

sudo apt install docker-ce docker-ce-cli containerd.io -y

#Docker Aktivieren
sudo systemctl start docker --now

#Benutzernamen hinzufügen für die Docker-Gruppe
sudo usermod -aG docker $USER

#Docker Compose Installieren
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
