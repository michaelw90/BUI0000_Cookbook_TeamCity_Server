#
# Cookbook Name:: cookbook_teamcity_server
# Recipe:: service
#

# Retrieve the useful variables for the recipe
data_directory = node['cookbook_teamcity_server']['teamcity']['data_dir']
teamcity_version = node['cookbook_teamcity_server']['teamcity']['version']
memory_options = node['cookbook_teamcity_server']['teamcity']['memory_options']

# Set the useful variables for the recipe
server_directory = "/opt/teamcity/#{teamcity_version}/TeamCity"
shell_script_path = "#{server_directory}/bin/teamcity.sh"


if node['cookbook_teamcity_server']['systemd']
  systemd_unit "teamcity.service" do
    enabled true
    active true
    content "[Unit]\nDescription=TeamCity\nAfter=network.target\n\n[Service]\nType=forking\nPIDFile=" + server_directory + "/logs/teamcity.pid\nExecStart=" + shell_script_path + " start\nExecStop=" + shell_script_path + " stop\n\nRestart=always\n[Install]\nWantedBy=multi-user.target"
    action [:create, :enable, :start]
  end
else
  # Create TeamCity Service
	template '/etc/init/teamcity-server.conf' do
	  source 'teamcity-server.conf.erb'
	  variables(
	    :server_path => server_directory,
	    :data_path => data_directory,
	    :memory_options => memory_options
	  )
	  notifies :start, 'service[teamcity-server]', :immediately
	end

	# Start TeamCity Service
	service "teamcity-server" do
	  provider Chef::Provider::Service::Upstart
	  action :restart
	end
end


