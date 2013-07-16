#
# Cookbook Name:: cron 
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2012, Ryutaro YOSHIBA 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in wrhiting, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
