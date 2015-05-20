#
# Cookbook Name:: awesome_customers
# Recipe:: webserver
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# install apache and configure its service
include_recipe 'apache2::default'

# Create and enable our custom site
web_app node['awesome_customers']['name'] do
  template "#{node['awesome_customers']['config']}.erb"
end

# create the document root
directory node['apache']['docroot_dir'] do
  recursive true
end

# write a default home page
file "#{node['apache']['docroot_dir']}/index.php" do
  content '<html>This is a placeholder</html>'
  mode '0644'
  owner node['awesome_customers']['user']
  group node['awesome_customers']['group']
end

# open port 80 to incoming traffic
firewall_rule 'http' do
  port 80
  protocol :tcp
  action :allow
end
