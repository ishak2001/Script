# System zu Aktualisieren
apt update -y
apt upgrade -y

# Benötigte Pakete Installieren
apt install wget build-essential libncursesw5-dev libssl-dev \
     libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev   -y

# Python3.11 Installieren
wget https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz

# Python3.11 entpacken
tar xzf Python-3.11.3.tgz 

# Python3.11 Kompilieren
./configure --enable-optimizations 

# Python3.11 Installieren
make altinstall
