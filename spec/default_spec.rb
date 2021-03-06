require_relative 'spec_helper'

describe 'autossh::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new.converge described_recipe
  end

  it 'installs package[autossh]' do
    expect(subject).to install_package('autossh')
  end
end
