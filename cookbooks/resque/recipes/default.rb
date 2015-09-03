#
# Cookbook Name:: resque
# Recipe:: default
#

# This recipe has been modified to be specifically tuned for the Importer

# Run resque workers only on utility VMs
# if ['app_master', 'app', 'solo'].include?(node[:instance_role])
if node[:instance_role] == "solo" || (node[:instance_role] == "util" && node[:name] !~ /resque/)
  
  execute "install resque gem" do
    command "gem install resque redis redis-namespace yajl-ruby -r"
    not_if { "gem list | grep resque" }
  end

  worker_count = 1

  node[:applications].each do |app, data|
    template "/etc/monit.d/resque_#{app}.monitrc" do
      owner 'root' 
      group 'root' 
      mode 0644 
      source "monitrc.conf.erb" 
      variables({ 
      :num_workers => worker_count,
      :app_name => app, 
      :rails_env => node[:environment][:framework_env] 
      }) 
    end

    worker_count.times do |count|
      template "/data/#{app}/shared/config/resque_#{count}.conf" do
        owner node[:owner_name]
        group node[:owner_name]
        mode 0644
        source "resque_wildcard.conf.erb"
      end
    end

    execute "ensure-resque-is-setup-with-monit" do 
      epic_fail true
      command %Q{ 
      monit reload 
      } 
    end
  end 
  
end
