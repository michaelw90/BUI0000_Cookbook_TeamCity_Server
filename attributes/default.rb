default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['cookbook_teamcity_server']['teamcity']['version'] = '2017.2.4'
default['cookbook_teamcity_server']['teamcity']['address'] = 'localhost'
default['cookbook_teamcity_server']['teamcity']['data_dir'] = '/root/.BuildServer'
default['cookbook_teamcity_server']['teamcity']['jdbc']['download_url'] = "http://ftp.kaist.ac.kr/mysql/Downloads/Connector-J/"
default['cookbook_teamcity_server']['teamcity']['jdbc']['filename'] = "mysql-connector-java-5.1.32.tar.gz"
default['cookbook_teamcity_server']['teamcity']['jdbc']['extract_command'] = "tar --strip-components=1 -zxvf mysql-connector-java-5.1.32.tar.gz mysql-connector-java-5.1.32/mysql-connector-java-5.1.32-bin.jar"
default['cookbook_teamcity_server']['teamcity']['memory_options'] = "-Xms750m -Xmx750m -XX:MaxPermSize=270m"

default['cookbook_teamcity_server']['teamcity']['database']['external'] = false
default['cookbook_teamcity_server']['teamcity']['database']['properties_file'] = 'database.mysql.properties.dist.erb'
default['cookbook_teamcity_server']['teamcity']['database']['host'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['name'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['port'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['username'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['password'] = nil