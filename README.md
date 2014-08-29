BEBUI0000_Cookbook_TeamCity_Server
===========================

The TeamCity Server cookbook.

To restore a TeamCity backup into this instance:
sudo -i
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
export TEAMCITY_APP_DIR=/opt/teamcity/current/TeamCity/webapps/teamcity/ROOT/
cp /root/.BuildServer/config/database.properties /root/database.properties.default
rm /root/.BuildServer/config -rf
cd /opt/teamcity/current/TeamCity/bin
./maintainDB.sh restore -F /vagrant/backup.zip -A /root/.BuildServer -T /root/database.properties.default