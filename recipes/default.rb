#
# Cookbook Name:: cron 
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2012, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

case node[:platform]
when "centos", "amazon"
  package "ntp" do
    action :install
  end

  cmd = "/usr/sbin/ntpdate -s ntp1.jst.mfeed.ad.jp"
  e = execute cmd do
    action :run
  end

  package "crontabs" do
    action :install
  end

  cron "ntpdate" do
    user "root"
    command cmd
  end
end

# vim: filetype=ruby.chef
