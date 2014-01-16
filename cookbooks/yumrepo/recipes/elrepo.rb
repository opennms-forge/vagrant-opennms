#
# Cookbook Name:: yumrepo
# Recipe:: elrepo 
#
# Copyright 2012, Panagiotis Papadomitsos
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

yum_key node['repo']['elrepo']['key'] do
  url  node['repo']['elrepo']['key_url']
  action :add
end

yum_repository "elrepo-base" do
  description "ELRepo.org Community Enterprise Linux Repository - el#{node.platform_version.to_i}"
  key node['repo']['elrepo']['key']
  url node['repo']['elrepo']['base_url']
  mirrorlist true
  action :add
end

yum_repository "elrepo-kernel" do
  description "ELRepo.org Community Enterprise Linux Kernel Repository - el#{node.platform_version.to_i}"
  key node['repo']['elrepo']['key']
  url node['repo']['elrepo']['kernel_url']
  mirrorlist true
  enabled 0
  action :add
end

yum_repository "elrepo-extras" do
  description "ELRepo.org Community Enterprise Linux Repository - el#{node.platform_version.to_i}"
  key node['repo']['elrepo']['key']
  url node['repo']['elrepo']['extras_url']
  mirrorlist true
  enabled 0
  action :add
end
