require_relative 'spec_helper'

describe 'autossh::services' do
  example = {
    enabled: true,
    bin: 'autossh',
    flags: '--custom-flags',
    ssh_port: 22,
    ssh_host: 'example.com',
    bind: '0.0.0.0',
    lport: 42,
    rport: 1337,
    luser: 'sliim',
    ruser: 'sliim',
  }

  let(:subject) do
    ChefSpec::SoloRunner.new(step_into: %w(autossh_service),
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['autossh']['example'] = example
    end.converge described_recipe
  end

  it 'creates autossh_service[example]' do
    expect(subject).to create_autossh_service('example')
      .with(enabled: true,
            bin: 'autossh',
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

  context 'disabled service' do
    let(:subject) do
      ChefSpec::SoloRunner.new(step_into: %w(autossh_service),
                               platform: 'debian',
                               version: '9.0') do |node|
        node.override['autossh']['example'] = example
        node.override['autossh']['example']['enabled'] = false
      end.converge described_recipe
    end

    it 'does not enable service[autossh-example]' do
      expect(subject).to_not enable_service('autossh-example')
    end

    it 'disables service[autossh-example]' do
      expect(subject).to disable_service('autossh-example')
    end
  end
end
