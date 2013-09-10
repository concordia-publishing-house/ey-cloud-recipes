#
# Cookbook Name:: nginx_redirects
# Recipe:: default
#

REDIRECTS = {
  # 360 LEDGER
  '360ledger.net'               => 'www.360ledger.com',
  'www.360ledger.net'           => 'www.360ledger.com',
  '360ledger.org'               => 'www.360ledger.com',
  'www.360ledger.org'           => 'www.360ledger.com',
  '360ledger.com'               => 'www.360ledger.com',

  # 360 MEMBERS
  '360members.net'              => 'www.360members.com',
  'www.360members.net'          => 'www.360members.com',
  '360members.org'              => 'www.360members.com',
  'www.360members.org'          => 'www.360members.com',
  '360members.com'              => 'www.360members.com',

  # 360 UNITE
  '360unite.net'                => 'www.360unite.com',
  'www.360unite.net'            => 'www.360unite.com',
  '360unite.org'                => 'www.360unite.com',
  'www.360unite.org'            => 'www.360unite.com',
  '360unite.com'                => 'www.360unite.com',

  # BIBLE STUDY BUILDER
  'biblestudybuilder.com'       => 'www.biblestudybuilder.com',

  # CHURCH 360
  'church360.net'               => 'www.church360.org',
  'www.church360.net'           => 'www.church360.org',
  'church360.com'               => 'www.church360.org',
  'www.church360.com'           => 'www.church360.org',
  'church360.org'               => 'www.church360.org',

  # CONFIRMATION BUILDER
  'confirmationbuilder.net'     => 'www.confirmationbuilder.com',
  'www.confirmationbuilder.net' => 'www.confirmationbuilder.com',
  'confirmationbuilder.org'     => 'www.confirmationbuilder.com',
  'www.confirmationbuilder.org' => 'www.confirmationbuilder.com',
  'confirmationbuilder.com'     => 'www.confirmationbuilder.com',

  # DR
  'lcmsdr.net'                  => 'www.lcmsdr.org',
  'www.lcmsdr.net'              => 'www.lcmsdr.org',
  'lcmsdr.com'                  => 'www.lcmsdr.org',
  'www.lcmsdr.com'              => 'www.lcmsdr.org',
  'lcmsdr.org'                  => 'www.lcmsdr.org',

  # MEMBER CALLER
  'membercaller.net'            => 'www.membercaller.com',
  'www.membercaller.net'        => 'www.membercaller.com',
  'membercaller.org'            => 'www.membercaller.com',
  'www.membercaller.org'        => 'www.membercaller.com',
  'membercaller.com'            => 'www.membercaller.com',

  # MY SUNDAY SOLUTIONS
  'mysundaysolutions.net'       => 'www.mysundaysolutions.com',
  'www.mysundaysolutions.net'   => 'www.mysundaysolutions.com',
  'mysundaysolutions.org'       => 'www.mysundaysolutions.com',
  'www.mysundaysolutions.org'   => 'www.mysundaysolutions.com',
  'mysundaysolutions.com'       => 'www.mysundaysolutions.com',

  # SHEPHERD'S STAFF
  'shepherdsstaff.org'          => 'www.shepherdsstaff.org',
  
  # WILDCARDS
  '*.360members.net'            => '*.360members.com',
  '*.360members.org'            => '*.360members.com',
  '*.church360.org'             => '*.360members.com',
  '*.360unite.net'              => '*.360unite.com',
  '*.360unite.org'              => '*.360unite.com'
}

if ['solo', 'app_master', 'app'].include? node[:instance_role]
  node[:engineyard][:environment][:apps].each do |app|
    REDIRECTS.each do |origin, destination|
      erb_template = "redirect.conf.erb"
      
      if origin.include?("*")
        origin = origin.gsub(/^\*\./, '')
        destination = destination.gsub(/^\*\./, '')
        erb_template = "wildcard_redirect.conf.erb"
      end
      
      template "/etc/nginx/servers/redirect.#{origin}.conf" do
        source erb_template
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
