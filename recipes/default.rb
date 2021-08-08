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

init_file = File.join(node['mongocookbook']['init_dir'].to_s, node['mongocookbook']['default_init_name'].to_s)
mode = '0755'


template "#{init_file} install" do
  path init_file
  cookbook node['mongodb']['template_cookbook']
  source node['mongodb']['init_script_template']
  group node['mongodb']['root_group']
  owner 'root'
  mode mode
  variables(
    provides: 'mongod',
    bind_ip: '0.0.0.0',
  )
  action :create_if_missing
end

packager_opts = '--nogpgcheck'
#package_version = "5.0.2-1.el8"
# install
script "Start mongod" do
	interpreter "bash"
	code <<-EOH
		systemctl start mongod.service
	EOH
end

#ensure mongo is enabled
script "Enable Mongod" do
	interpreter "bash"
        code <<-EOH
                chkconfig mongod on
        EOH
end


