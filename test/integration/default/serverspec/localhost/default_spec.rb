require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/usr/sbin"
end

describe package('ntpdate') do
  it { should be_installed }
end

describe file('/usr/sbin/ntpdate') do
  it { should be_file }
  it { should be_mode 755 }
end

describe cron do
  it { should have_entry('0 4 * * * /usr/sbin/ntpdate ntp.nict.jp').with_user('root') }
end
