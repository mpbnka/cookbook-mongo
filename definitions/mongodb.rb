define :mongodb_instance,
       :mongodb_type  => 'mongod',
       :action        => [:enable, :start],
       :logpath       => '/var/log/mongodb/mongodb.log',
       :dbpath        => '/data/db/',
       :configservers => [],
       :replicaset    => nil,
       :notifies      => [] do

  provider = 'mongod'

  new_resource = OpenStruct.new

  new_resource.name                       = params[:name]
  new_resource.dbpath                     = params[:dbpath]
  new_resource.logpath                    = params[:logpath]

  new_resource.mongodb_group              = node['mongodb']['group']
  new_resource.mongodb_user               = node['mongodb']['user']
  new_resource.init_dir                   = node['mongodb']['init_dir']
  new_resource.init_script_template       = node['mongodb']['init_script_template']

  new_resource.init_file = File.join(node['mongocookbook']['init_dir'].to_s, new_resource.name.to_s)
  mode = '0755'

  # log dir [make sure it exists]
  if new_resource.logpath
    directory File.dirname(new_resource.logpath) do
      owner new_resource.mongodb_user
      group new_resource.mongodb_group
      mode '0755'
      action :create
      recursive true
    end
  end

  # dbpath dir [make sure it exists]
  directory new_resource.dbpath do
    owner new_resource.mongodb_user
    group new_resource.mongodb_group
    mode '0755'
    action :create
    recursive true
  end

  # Reload systemctl for RHEL 7+ after modifying the init file.
  execute 'mongodb-systemctl-daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
  end

# init script
  template new_resource.init_file do
    cookbook new_resource.template_cookbook
    source new_resource.init_script_template
    group new_resource.root_group
    owner 'root'
    mode mode
    variables(
      :provides =>       provider,
      :dbconfig_file  => new_resource.dbconfig_file,
      :sysconfig_file => new_resource.sysconfig_file,
      :ulimit =>         new_resource.ulimit,
      :bind_ip =>        new_resource.bind_ip,
      :port =>           new_resource.port
    )
  #  notifies new_resource.reload_action, "service[#{new_resource.name}]"

    notifies :run, 'execute[mongodb-systemctl-daemon-reload]', :immediately
  end


end

