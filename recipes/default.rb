#
# Cookbook:: mongocookbook
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

node.override['mongodb']['package_name'] = 'mongodb-org'

# install mongodb for redhat based systems
yum_repository 'mongodb' do
    description 'mongo RPM Repository'
    baseurl node['mongocookbook']['repository']['url']
    action :create
    gpgcheck false
    enabled true
end

