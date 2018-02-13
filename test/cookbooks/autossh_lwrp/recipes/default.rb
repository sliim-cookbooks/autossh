# -*- coding: utf-8 -*-

include_recipe 'autossh'

autossh_service 'kitchen' do
  ssh_host 'localhost'
  lport 42
  rport 22
  luser 'kitchen'
  ruser 'kitchen'
end
