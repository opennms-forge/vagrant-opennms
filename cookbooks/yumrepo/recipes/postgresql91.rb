#
# Cookbook Name:: yumrepo
# Recipe:: postgresql91
#
# Copyright 2012, Bryan W. Berry (<bryan.berry@gmail.com>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cookbook_file "#{node["repo"]["key_path"]}/#{node["repo"]["postgresql91"]["key"]}"

yum_key node["repo"]["postgresql91"]["key"] do
  action :add
end

yum_repository "postgresql91" do
  description "PostgreSQL 9.1"
  key node["repo"]["postgresql91"]["key"]
  url node["repo"]["postgresql91"]["url"]
  action :add
end
