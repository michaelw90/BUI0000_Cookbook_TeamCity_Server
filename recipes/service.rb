#
# Cookbook Name:: cookbook_teamcity_server
# Recipe:: service
#

# Retrieve the useful variables for the recipe
data_directory = node['cookbook_teamcity_server']['teamcity']['data_dir']
teamcity_version = node['cookbook_teamcity_server']['teamcity']['version']

# Set the useful variables for the recipe
server_directory = "/opt/teamcity/#{teamcity_version}"


# Create TeamCity Service
template '/etc/init/teamcity-server.conf' do
  source 'teamcity-server.conf.erb'
  variables(
    :server_path => server_directory,
    :data_path => data_directory
  )
  notifies :start, 'service[teamcity-server]', :immediately
end

# Start TeamCity Service
service "teamcity-server" do
  provider Chef::Provider::Service::Upstart
  action :restart
end