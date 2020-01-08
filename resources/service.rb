# Cookbook:: autossh
# Resource:: service
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

resource_name :autossh_service
provides :autossh_service

property :enabled, [true, false], default: true
property :bin, String, default: '/usr/bin/autossh'
property :flags, String, default: '-NR'
property :ssh_host, String, default: ''
property :ssh_port, Integer, default: 22
property :bind, String, default: 'localhost'
property :lport, Integer, default: 2222
property :rport, Integer, default: 22
property :luser, String, default: 'root'
property :ruser, String, default: 'root'

action :create do
  template "/etc/systemd/system/autossh-#{new_resource.name}.service" do
    owner 'root'
    group 'root'
    mode '0644'
    source 'autossh.service.erb'
    cookbook 'autossh'
    variables bin: new_resource.bin,
              flags: new_resource.flags,
              ssh_port: new_resource.ssh_port,
              ssh_host: new_resource.ssh_host,
              bind: new_resource.bind,
              lport: new_resource.lport,
              rport: new_resource.rport,
              luser: new_resource.luser,
              ruser: new_resource.ruser
    notifies :run, 'execute[systemctl-daemon-reload]', :immediately
    notifies :restart, "service[autossh-#{new_resource.name}]", :delayed
  end

  service "autossh-#{new_resource.name}" do
    action new_resource.enabled ? :enable : :disable
    supports status: true, start: true, stop: true, restart: true
  end
end

action :delete do
  service "autossh-#{new_resource.name}" do
    action :disable
  end

  file "/etc/systemd/system/autossh-#{new_resource.name}.service" do
    action :delete
  end
end
