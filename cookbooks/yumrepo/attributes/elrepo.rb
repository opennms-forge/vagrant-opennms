#
# Cookbook Name:: yumrepo
# Attributes:: elrepo 
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

default['repo']['elrepo']['base_url'] = "http://elrepo.org/mirrors-elrepo.el#{platform_version.to_i}"
default['repo']['elrepo']['kernel_url'] = "http://elrepo.org/mirrors-elrepo-kernel.el#{platform_version.to_i}"
default['repo']['elrepo']['extras_url'] = "http://elrepo.org/mirrors-elrepo-extras.el#{platform_version.to_i}"
set['repo']['elrepo']['key'] = "RPM-GPG-KEY-elrepo.org"
default['repo']['elrepo']['key_url'] = "http://elrepo.org/RPM-GPG-KEY-elrepo.org"
