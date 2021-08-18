#
# Cookbook:: mongocookbook
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# update yum
execute 'yum_update_upgrade' do
	command 'yum update && sudo yum upgrade'
end

node.override['mongodb']['package_name'] = 'mongodb-org'

# install mongodb for redhat based systems
yum_repository 'mongodb' do
    description 'mongo RPM Repository'
    baseurl node['mongocookbook']['repository']['url']
    gpgcheck false
    enabled true
    action :create
end

build_essential 'build-tools'


# install
# script "Start mongod" do
# 	interpreter "bash"
# 	code <<-EOH
# 		systemctl start mongod.service
# 	EOH
# end
service "mongod" do
  action :start
end

#ensure mongo is enabled
script "Enable Mongod" do
	interpreter "bash"
        code <<-EOH
                chkconfig mongod on
        EOH
end


