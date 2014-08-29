#
# Cookbook Name:: cookbook_teamcity_server
# Recipe:: default
#

include_recipe 'appbox'
include_recipe 'java::default'
include_recipe 'cookbook_teamcity_server::teamcity'
include_recipe 'cookbook_teamcity_server::plugins'
include_recipe 'cookbook_teamcity_server::service'