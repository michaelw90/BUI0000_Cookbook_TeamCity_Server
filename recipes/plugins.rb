#
# Cookbook Name:: cookbook_teamcity_server
# Recipe:: plugins
#

# Retrieve the useful variables for the recipe
data_directory = node['cookbook_teamcity_server']['teamcity']['data_dir']

# Set the useful variables for the recipe
data_plugins_directory = "#{data_directory}/plugins"

# Install the Github plugin.
# This enabled communication to the Github pull requests.
cookbook_file "#{data_plugins_directory}/teamcity.github.zip" do
  backup false
  source "teamcity.github.zip"
  action :create_if_missing
end