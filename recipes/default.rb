#
# Cookbook Name:: ntp 
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2012, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

include_recipe "cron"

case node[:platform]
when "centos", "amazon", "ubuntu"
  package "ntpdate" do
    action :install
  end

  cmd = "/usr/sbin/ntpdate #{node["ntp"]["target"]}"
  e = execute cmd do
    action :run
  end

  cron_d "ntpdate" do
    minute node["ntp"]["minute"]
    hour   node["ntp"]["hour"]
    command cmd
    user "root"
  end
end

# vim: filetype=ruby.chef
