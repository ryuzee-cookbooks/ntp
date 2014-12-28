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

case node[:platform]
when 'centos', 'amazon'

  node['platform_version'].to_f >= 6.0 ? p = 'cronie' : p = 'vixie-cron'

  yum_package p do
    action :install
    flush_cache [:before]
  end

  yum_package 'ntp' do
    action :install
    flush_cache [:before]
  end

when 'ubuntu', 'debian'
  include_recipe "apt"
  package 'cron' do
    action :install
  end
  package 'ntpdate' do
    action :install
  end
end

cmd = "/usr/sbin/ntpdate #{node['ntp']['target']}"

cron 'ntpdate' do
  minute node['ntp']['minute']
  hour   node['ntp']['hour']
  day    node['ntp']['day']
  month  node['ntp']['month']
  weekday node['ntp']['weekday']
  command cmd
  user 'root'
  action :create
end

execute cmd do
  action :run
  not_if {'ps -ef | grep ntpd'}
end

# vim: filetype=ruby.chef
