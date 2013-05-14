#
# Cookbook Name: heroku-database-yml
# Recipe: default
#
# Description:
# Configure application servers to use mysql2 adapter for the database.yml config.
# All parameters except the adapter are pulled from the EY node JSON element. See
# http://docs.engineyard.com/use-deploy-hooks-with-engine-yard-cloud.html for an
# example of the node JSON object. This object is also used for by deploy hooks
# at Engine Yard.
#
#
# c.f. https://gist.github.com/jeremy2/1989695
# c.f. https://github.com/heroku/heroku-buildpack-ruby/blob/v34/lib/language_pack/ruby.rb#L440-503
#
#
# Q: Why do we need this custom recipe?
#
# A: We are hosting our databases elsewhere and are connecting to them
# using a connection string
#
 
if ['solo', 'app_master', 'app', 'util'].include?(node[:instance_role])
  
  # for each application
  node[:engineyard][:environment][:apps].each do |app|
    
    # create new database.yml
    template "/data/#{app[:name]}/shared/config/database.yml" do
      source 'database.yml.erb'
      owner node[:users][0][:username]
      group node[:users][0][:username]
      mode 0644
      variables({
        :environment => node[:environment][:framework_env],
        :adapter => 'postgresql'
      })
    end
  end
end