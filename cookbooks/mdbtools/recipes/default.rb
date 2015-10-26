#
# Cookbook Name:: mdbtools
# Recipe:: default
#

TEMP_PATH = "/etc/chef-custom/tmp"

bash "install_mdbtools" do
  code <<-BASH
    mkdir -p #{TEMP_PATH}
    git clone --branch 0.7.1 git://github.com/brianb/mdbtools.git #{TEMP_PATH}/mdbtools
    cd "#{TEMP_PATH}/mdbtools"
    autoreconf -i -f
    ./configure --disable-man
    make
    make install
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
  BASH
  not_if { `which mdb-export`.length > 0 }
end
