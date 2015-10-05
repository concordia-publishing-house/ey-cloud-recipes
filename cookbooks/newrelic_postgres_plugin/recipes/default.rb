#
# Cookbook Name:: newrelic_postgres_plugin
# Recipe:: default
# https://github.com/GoBoundless/newrelic_postgres_plugin
#

if ['app_master', 'solo'].include?(node[:instance_role])
  
  directory "/opt/newrelic/postgres/config" do
    action :create
    recursive true
    owner 'root'
    group 'root'
  end
  
  template "/opt/newrelic/postgres/config/newrelic_plugin.yml" do
    source "newrelic_plugin.yml.erb"
    owner 'root'
    group 'root'
    mode 0644
    backup 0
    variables(
      :key      => node[:newrelic][:license_key],
      :host     => node[:postgres][:host],
      :port     => node[:postgres][:port],
      :user     => node[:postgres][:user],
      :password => node[:postgres][:password],
      :dbname   => node[:postgres][:dbname],
      :sslmode  => node[:postgres][:sslmode],
      :label    => node[:postgres][:label])
  end
  
  execute "install newrelic_plugin gem" do
    command "sudo gem install newrelic_plugin --version=1.0.3"
    not_if { "sudo gem list | grep newrelic_plugin" }
  end
  
  execute "install newrelic_postgres_plugin gem" do
    command "sudo gem install newrelic_postgres_plugin"
    not_if { "sudo gem list | grep newrelic_postgres_plugin" }
  end
  
  remote_file "/etc/monit.d/newrelic_postgres_plugin.monitrc" do
    source "newrelic_postgres_plugin.monitrc"
    owner "root"
    group "root"
    mode 0644
    backup 0
  end
  
  remote_file "/etc/init.d/newrelic_postgres_plugin" do
    source "newrelic_postgres_plugin.initd"
    owner "root"
    group "root"
    mode 0755
  end

  execute "monit reload" do
    action :run
  end

end
