#
# Cookbook Name:: mdbtools
# Recipe:: default
#

git "#{Chef::Config[:file_cache_path]}/mdbtools" do
   repository "git://github.com/brianb/mdbtools.git"
   revision "eeadcb54f3e0df8c513ff598ff56be1c77f63acf"
   action :sync
   notifies :run, "bash[install_mdbtools]"
end

bash "install_mdbtools" do
   cwd "#{Chef::Config[:file_cache_path]}/mdbtools"
   code <<-EOH
     ./autogen.sh
     make
     make install
     EOH
end
