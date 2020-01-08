describe file '/etc/systemd/system/autossh-kitchen.service' do
  it { should be_file }
  it { should be_mode 0640 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe service 'autossh-kitchen' do
  it { should be_enabled }
end
