default['cookbook_teamcity_server']['teamcity']['version'] = '8.1.4'
default['cookbook_teamcity_server']['teamcity']['address'] = 'localhost'
default['cookbook_teamcity_server']['teamcity']['data_dir'] = '/root/.BuildServer'
default['cookbook_teamcity_server']['teamcity']['jdbc']['download_url'] = "http://ftp.kaist.ac.kr/mysql/Downloads/Connector-J/"
default['cookbook_teamcity_server']['teamcity']['jdbc']['filename'] = "mysql-connector-java-5.1.32.tar.gz"

default['cookbook_teamcity_server']['teamcity']['database']['external'] = false
default['cookbook_teamcity_server']['teamcity']['database']['properties_file'] = 'database.mysql.properties.dist.erb'
default['cookbook_teamcity_server']['teamcity']['database']['host'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['name'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['port'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['username'] = nil
default['cookbook_teamcity_server']['teamcity']['database']['password'] = nil