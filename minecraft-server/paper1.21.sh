#Erforderliche Pakete Installieren
apt update && apt upgrade -y
apt install -y wget screen

#GPG-Schlüssel von BellSoft Herunterladen
wget -O /etc/apt/trusted.gpg.d/bellsoft.asc https://download.bell-sw.com/pki/GPG-KEY-bellsoft

#BellSoft-Repository zu Paketen hinzufügen
echo "deb [signed-by=/etc/apt/trusted.gpg.d/bellsoft.asc] https://apt.bell-sw.com/ stable main" | sudo tee /etc/apt/sources.list.d/bellsoft.list

#Pakete Aktuallisieren
apt update

#Java21 Installieren
sudo apt install -y bellsoft-java21

#Minecraft Ordner erstellen
mkdir /home/minecraft

#Minecraft Ordner Navigieren
cd /home/minecraft

#Minecraft 1.21 Jar Installieren
wget -O paper.jar "https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/105/downloads/paper-1.21.1-105.jar"

#EULA akzeptieren
echo "eula=true" > eula.txt

#Startskript erstellen
cat <<EOF > start.sh
while true
do
  java -jar paper.jar
  echo 'Willst Du den Server komplett stoppen, drücke STRG+C!'
  echo "Neustart in:"
  for i in 5 4 3 2 1
  do
  echo "$i..."
  sleep 1
  done
  echo 'Server neustart!'
done
EOF

#Rechte für das Startskript setzen
chmod +x start.sh
