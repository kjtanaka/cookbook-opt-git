#
# Cookbook Name:: opt-git
# Recipe:: default
#
# Copyright 2014, Indiana University
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential'

node['opt-git']['packages'].each do |pkg| package pkg end

remote_file "#{node['opt-git']['download_dir']}/git-#{node['opt-git']['version']}.tar.gz" do
  source node['opt-git']['download_url']
  owner "root"
  group "root"
  mode "0644"
  not_if { ::File.exists?("#{node['opt-git']['prefix']}/bin") }
end

execute "extract_git" do
  cwd node['opt-git']['download_dir']
  user "root"
  command "tar zxf git-#{node['opt-git']['version']}.tar.gz"
  only_if { ::File.exists?("#{node['opt-git']['download_dir']}/git-#{node['opt-git']['version']}.tar.gz") }
  creates "git-#{node['opt-git']['version']}"
end

bash "install_git" do
  cwd "#{node['opt-git']['download_dir']}/git-#{node['opt-git']['version']}"
  user "root"
  code <<-EOH
  make configure
  ./configure --prefix=#{node['opt-git']['prefix']}
  make
  make install
  EOH
  only_if { ::File.exists?("#{node['opt-git']['download_dir']}/git-#{node['opt-git']['version']}") }
  creates "#{node['opt-git']['prefix']}/bin"
end
