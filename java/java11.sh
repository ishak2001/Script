#!/bin/bash
wget -O /tmp/java11.tar.gz 'http://185.244.166.170/oracle-java11/openjdk-11.0.2_linux-x64_bin.tar.gz';
mkdir -p /opt/oracle_java11-0-2
tar -xvf /tmp/java11.tar.gz -C /opt/oracle_java11-0-2 --strip-components=1
update-alternatives --install "/usr/bin/java11" "java11" "/opt/oracle_java11-0-2/bin/java" 1
update-alternatives --set "java11" "/opt/oracle_java11-0-2/bin/java"
rm -f /tmp/java11.tar.gz;
exit 0;
