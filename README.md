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



Depending on what memory you allocate the process and what is available on your server, you may get the following error when TeamCity checks VCS roots:
java.io.IOException: error=12, Cannot allocate memory

You can fix by running:
echo 1 > /proc/sys/vm/overcommit_memory

A good article if provided by atlassian here as to what is going on:
https://confluence.atlassian.com/display/FISHKB/java.io.IOException%3A+error%3D12,+Cannot+allocate+memory
