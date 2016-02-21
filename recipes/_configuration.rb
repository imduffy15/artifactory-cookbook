#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright 2016 Ian Duffy
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

template "#{node['artifactory']['conf_dir']}/tomcat/conf/server.xml" do
  source 'server.xml.erb'
  owner 'root'
  group 'root'
  mode '0775'
  notifies :restart, 'service[artifactory]', :delayed
end

nginx_reverse_proxy 'artifactory.lan.ianduffy.ie' do
  application_host node['artifactory']['bind']['ip']
  application_port node['artifactory']['bind']['port']
  http_ports ['80 default_server']
  template 'artifactory_reverse_proxy.erb'
end

nginx_reverse_proxy 'centos.direct.mirror.lan.ianduffy.ie' do
  application_host 'http://centos.hyve.com'
  application_port 80
  http_server_name 'centos.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'fedora.direct.mirror.lan.ianduffy.ie' do
  application_host 'http://dl.fedoraproject.org'
  application_port 80
  http_server_name 'fedora.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'debian.direct.mirror.lan.ianduffy.ie' do
  application_host 'http://ftp.ie.debian.org'
  application_port 80
  http_server_name 'debian.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'rubygems.direct.mirror.lan.ianduffy.ie' do
  application_host 'https://rubygems.org'
  application_port 443
  http_server_name 'rubygems.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'supermarket.direct.mirror.lan.ianduffy.ie' do
  application_host 'https://supermarket.chef.io'
  application_port 443
  http_server_name 'supermarket.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'github.direct.mirror.lan.ianduffy.ie' do
  application_host 'https://github.com'
  application_port 443
  http_server_name 'github.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_mirrors.erb'
end

nginx_reverse_proxy 'bower.direct.mirror.lan.ianduffy.ie' do
  application_host 'http://bower.herokuapp.com'
  application_port 80
  http_server_name 'bower.direct.mirror.lan.ianduffy.ie'
  http_ports ['80']
  template 'remote_bower_mirror.erb'
end

service node['artifactory']['service']['name'] do
  supports status: true, restart: true
  action [:start, :enable]
end
