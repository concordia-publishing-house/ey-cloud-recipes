#
# Cookbook Name:: mdbtools
# Recipe:: default
#

TEMP_PATH = "/etc/chef-custom/tmp"

bash "install_mdbtools" do
  code <<-BASH
    mkdir -p #{TEMP_PATH}
    git clone git://github.com/brianb/mdbtools.git #{TEMP_PATH}/mdbtools
    cd "#{TEMP_PATH}/mdbtools"
    ./autogen.sh
    make
    make install
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
  BASH
end
