# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'autossh::services' do
  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(autossh_service),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['autossh']['example']['bin'] = 'autossh'
      node.override['autossh']['example']['flags'] = '--custom-flags'
      node.override['autossh']['example']['ssh_port'] = 22
      node.override['autossh']['example']['ssh_host'] = 'example.com'
      node.override['autossh']['example']['bind'] = '0.0.0.0'
      node.override['autossh']['example']['lport'] = 42
      node.override['autossh']['example']['rport'] = 1337
      node.override['autossh']['example']['luser'] = 'sliim'
      node.override['autossh']['example']['ruser'] = 'sliim'
    end.converge described_recipe
  end

  it 'creates autossh_service[example]' do
    expect(subject).to create_autossh_service('example')
      .with(bin: 'autossh',
            flags: '--custom-flags',
            ssh_port: 22,
            ssh_host: 'example.com',
            bind: '0.0.0.0',
            lport: 42,
            rport: 1337,
            luser: 'sliim',
            ruser: 'sliim')
  end

  it 'creates template[/etc/systemd/system/autossh-example.service]' do
    expect(subject).to create_template('/etc/systemd/system/autossh-example.service')
      .with(owner: 'root',
            group: 'root',
            mode: '0644',
            source: 'autossh.service.erb')
  end

  it 'enables service[autossh-example]' do
    expect(subject).to enable_service('autossh-example')
  end
end
