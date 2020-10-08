#
# Cookbook Name:: cookbook_teamcity_server
# Recipe:: teamcity
#

# Retrieve the useful variables for the recipe
archive_directory = Chef::Config[:file_cache_path]
data_directory = node['cookbook_teamcity_server']['teamcity']['data_dir']
teamcity_version = node['cookbook_teamcity_server']['teamcity']['version']
jdbc_driver_download_url = node['cookbook_teamcity_server']['teamcity']['jdbc']['download_url']
jdbc_driver_filename = node['cookbook_teamcity_server']['teamcity']['jdbc']['filename']
address = node['cookbook_teamcity_server']['teamcity']['address']
database = node['cookbook_teamcity_server']['teamcity']['database']
extract_command = node['cookbook_teamcity_server']['teamcity']['jdbc']['extract_command']

# Set the useful variables for the recipe
server_archive_name = "TeamCity-#{teamcity_version}.tar.gz"
server_directory = "/opt/teamcity/#{teamcity_version}"
config_directory = "#{server_directory}/TeamCity/conf"
webapps_directory = "#{server_directory}/TeamCity/webapps"
teamcity_directory = "#{webapps_directory}/teamcity"
jdbc_driver_directory = "#{data_directory}/lib/jdbc"
data_config_directory = "#{data_directory}/config"
data_plugins_directory = "#{data_directory}/plugins"
server_archive_path = "#{archive_directory}/#{server_archive_name}"
database_properties_file = "#{data_config_directory}/database.properties"

# Download the version of teamcity, if we don't already have it
remote_file server_archive_path do
  backup false
  source "https://download.jetbrains.com/teamcity/#{server_archive_name}"
  action :create_if_missing
  notifies :run, "bash[install-teamcity]", :immediately
end

# Run the commands to extract and move teamcity into place.
bash "install-teamcity" do
  code <<-EOH
    mkdir -p #{server_directory}
    cd #{server_directory}
    tar -xvf #{server_archive_path}
    mkdir -p #{teamcity_directory}
    mv #{webapps_directory}/ROOT #{teamcity_directory}/ROOT
  EOH
  action :nothing
end

# Set the symbolic link to the current teamcity installation
link '/opt/teamcity/current' do
  to server_directory
end

# Create the data configuration directory
directory data_config_directory do
  recursive true
  action :create
end

# If we are using an external database and all properties are set
if database['external'] && database['external'] == true && database['host'] && database['port'] && database['name'] && database['username'] && database['password']


# Run the commands to extract and move teamcity into place.
  bash "extract-driver" do
    code <<-EOH
    cd #{jdbc_driver_directory}
    #{extract_command}
    EOH
    action :nothing
    only_if { extract_command }
  end

  # Setup the database properties file for TeamCity
  template database_properties_file do
    source database['properties_file']
    action :create
    variables(
      :host => database['host'],
      :port => database['port'],
      :name => database['name'],
      :user => database['username'],
      :password => database['password']
    )
  end

else

  # Setup the database properties file for TeamCity using the default internal database hsql
  template database_properties_file do
    source "database.hsqldb.properties.dist.erb"
    action :create
  end

end

# Create the data configuration directory
directory data_plugins_directory do
  recursive true
  action :create
end

# Configure TeamCity TomCat server
template "#{config_directory}/server.xml" do
  source 'server.xml.erb'
  variables(
      :address => address
  )
end