# Cookbook:: autossh
# Recipe:: services
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

execute 'systemctl-daemon-reload' do
  action :nothing
  command 'systemctl daemon-reload'
end

node['autossh'].each do |name, config|
  autossh_service name do
    enabled config['enabled'] if config.key? 'enabled'
    bin config['bin'] if config.key? 'bin'
    flags config['flags'] if config.key? 'flags'
    ssh_port config['ssh_port'] if config.key? 'ssh_port'
    ssh_host config['ssh_host'] if config.key? 'ssh_host'
    bind config['bind'] if config.key? 'bind'
    lport config['lport'] if config.key? 'lport'
    rport config['rport'] if config.key? 'rport'
    luser config['luser'] if config.key? 'luser'
    ruser config['ruser'] if config.key? 'ruser'
  end
end
