#!/bin/bash
wget -O /tmp/java8.tar.gz 'http://185.244.166.170/oracle-java8/jre-8u271-linux-x64.tar.gz';
mkdir -p /opt/oracle_java8u271
tar -xvf /tmp/java8.tar.gz -C /opt/oracle_java8u271 --strip-components=1
update-alternatives --install "/usr/bin/java" "java" "/opt/oracle_java8u271/bin/java" 1
update-alternatives --set "java" "/opt/oracle_java8u271/bin/java"
rm -f /tmp/java8.tar.gz;
exit 0;
