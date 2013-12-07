require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/usr/sbin"
end

describe package('ntp') do
  it { should be_installed }
end

describe package('ntpdate') do
  it { should be_installed }
end

describe file('/usr/sbin/ntpdate') do
  it { should be_file }
  it { should be_mode 755 }
end

describe file('/etc/cron.d/ntpdate') do
  it { should be_file }
  it { should contain '0 4 * * * root /usr/sbin/ntpdate ntp.nict.jp' }
end
