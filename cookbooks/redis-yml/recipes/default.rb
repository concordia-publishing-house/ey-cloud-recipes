if ['app_master', 'app', 'solo'].include?(node[:instance_role])
  
  instances = node[:engineyard][:environment][:instances]
  redis_instance = instances.length == 1 ? instances[0] : instances.find { |instance| instance['name'] == 'redis' }
  
  if redis_instance
    node[:applications].each do |app, data|
      template "/data/#{app}/shared/config/redis.yml"do
        source 'redis.yml.erb'
        owner node[:owner_name]
        group node[:owner_name]
        mode 0655
        backup 0
        variables({
          :environment => node[:environment][:framework_env],
          :hostname => redis_instance[:hostname]
        })
      end
    end
  end
end