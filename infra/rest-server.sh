#!/bin/bash

wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
sudo tar xzf apache-maven-3.3.9-bin.tar.gz --directory /opt
sudo ln -s /opt/apache-maven-3.3.9 /opt/maven
rm -rf apache-maven-3.3.9-bin.tar.gz

sudo cat <<EOF>  /etc/profile.d/maven.sh
export M2_HOME=/opt/maven
export M2=\$M2_HOME/bin
export PATH=\$M2:${PATH}
EOF

source /etc/profile.d/maven.sh

cd infra
adduser rest
sudo cp rest.service /usr/lib/systemd/system/
sudo systemctl enable rest.service
sudo systemctl daemon-reload
sudo systemctl stop rest.service

cd ../app
git pull origin develop
mvn clean install
sudo mkdir /opt/server
sudo cp -R rest-front/config /opt/server
sudo cp -R rest-front/target/rest-front-0.0.1-SNAPSHOT.jar /opt/server/server.jar

# sudo systemctl start rest.service
sudo systemctl status rest.service

git config --global user.email $GITEMAIL
git config --global user.name $GITNAME
git status

cd ~

echo -e "SERVER ENDED"
