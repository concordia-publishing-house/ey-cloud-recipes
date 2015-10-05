#
# Cookbook Name:: dotfiles
# Recipe:: default
#

git "/home/deploy/Me" do
  repository "git://github.com/boblail/dotfiles.git"
  reference "master"
  action :sync
  user "deploy"
end

bash "add_dotfiles_to_bash_profile" do
  user "deploy"
  code "echo \". /home/deploy/Me/bash_profile\" >> /home/deploy/.bash_profile"
  not_if { ::File.read("/home/deploy/.bash_profile") =~ /\/Me\/bash_profile/ }
end

bash "compile_vcprompt" do
  cwd "/home/deploy/Me/src/vcprompt-07f110976599"
  user "deploy"
  code "make"
  not_if { ::File.exists?("/home/deploy/Me/src/vcprompt-07f110976599/vcprompt") }
end
