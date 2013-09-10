#
# Cookbook Name:: nginx_wildcard_redirects
# Recipe:: default
#

REDIRECTS = {
  '360members.net' => '360members.com',
  '360members.org' => '360members.com',
  'church360.org'  => '360members.com',
  '360unite.net'   => '360unite.com',
  '360unite.org'   => '360unite.com'
}

if node[:instance_role] == 'solo'
  node[:engineyard][:environment][:apps].each do |app|
    REDIRECTS.each do |origin, destination|
      template "/etc/nginx/servers/#{app[:name]}/z.#{origin}.conf" do
        source 'redirect.conf.erb'
        owner node[:users][0][:username]
        group node[:users][0][:username]
        mode 0644

        variables({
          origin: origin,
          destination: destination
        })
      end
    end

    execute "sudo /etc/init.d/nginx reload"
  end
end
