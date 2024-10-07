#!/bin/bash
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

#Erforderliche Updates
apt update
