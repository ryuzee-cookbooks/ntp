require 'spec_helper'

if os[:family] == 'ubuntu'
  describe package('ntpdate') do
    it { should be_installed }
  end
elsif os[:family] == 'redhat'
  describe package('ntp') do
    it { should be_installed }
  end
end

describe file('/usr/sbin/ntpdate') do
  it { should be_file }
end

describe cron do
  it { should have_entry('0 4 * * * /usr/sbin/ntpdate ntp.nict.jp').with_user('root') }
end
