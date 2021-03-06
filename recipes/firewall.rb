# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: firewall
#
# Copyright (C) 2014, Darron Froese <darron@froese.org>
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

include_recipe 'firewall::default'

package 'ufw' do
  action :install
end

firewall 'ufw' do
  action :enable
end

firewall_rule 'ssh' do
  port     22
  action   :allow
  notifies :enable, 'firewall[ufw]'
end

firewall_rule 'http' do
  port     80
  action   :allow
  notifies :enable, 'firewall[ufw]'
end

firewall_rule 'https' do
  port     443
  action   :allow
  notifies :enable, 'firewall[ufw]'
end

bash 'allow connections from docker0' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  /usr/sbin/ufw allow in on docker0
  EOH
end
