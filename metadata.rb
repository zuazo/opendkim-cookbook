# Cookbook Name:: opendkim
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL.
# License:: Apache License, Version 2.0
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

name 'opendkim'
maintainer 'Xabier de Zuazo'
maintainer_email 'xabier@zuazo.org'
license 'Apache 2.0'
description <<-EOH
  Installs and configures OpenDKIM: Open source implementation of the DKIM
  (Domain Keys Identified Mail) sender authentication system.
EOH
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

if respond_to?(:source_url)
  source_url "https://github.com/zuazo/#{name}-cookbook"
end
if respond_to?(:issues_url)
  issues_url "https://github.com/zuazo/#{name}-cookbook/issues"
end

chef_version '>= 12' if respond_to?(:chef_version)

supports 'amazon'
supports 'debian'
supports 'centos'
supports 'fedora'
supports 'freebsd'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'

depends 'yum-epel', '~> 0.5'

recipe 'opendkim::default', 'Installs and configures OpenDKIM.'

attribute 'opendkim/conf',
          display_name: 'opendkim conf',
          description: 'OpenDKIM configuration hash.',
          type: 'hash',
          required: 'recommended',
          calculated: true

attribute 'opendkim/conf_file',
          display_name: 'opendkim conf file',
          description: 'OpenDKIM Configuration file path.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'opendkim/require_yum_epel',
          display_name: 'opendkim require yum epel',
          description: 'Whether to include `yum-epel` recipe.',
          type: 'string',
          required: 'optional',
          choice: %w(true false),
          calculated: true

grouping 'opendkim/service',
         description: 'OpenDKIM service platform related configurations.'

attribute 'opendkim/service/name',
          display_name: 'opendkim service name',
          description: 'OpenDKIM system service name.',
          type: 'string',
          required: 'optional',
          calculated: true

attribute 'opendkim/service/supports',
          display_name: 'opendkim service supports',
          description: 'OpenDKIM service supported actions.',
          type: 'hash',
          required: 'optional',
          calculated: true

grouping 'opendkim/packages',
         description: 'OpenDKIM distribution package names.'

attribute 'opendkim/packages/tools',
          display_name: 'opendkim packages tools',
          description:
            'OpenDKIM tools package name as array (currently unused).',
          type: 'array',
          required: 'optional',
          calculated: true

attribute 'opendkim/packages/service',
          display_name: 'opendkim packages service',
          description: 'OpenDKIM daemon package name as array.',
          type: 'array',
          required: 'optional',
          default: %w(opendkim)

attribute 'opendkim/run_dir',
          display_name: 'opendkim run dir',
          description:
            'OpenDKIM run directory used for the pidfile and as home for the '\
            'system user.',
          type: 'string',
          required: 'optional',
          default: '/var/run/opendkim'

attribute 'opendkim/user',
          display_name: 'opendkim user',
          description: 'OpenDKIM system user name.',
          type: 'string',
          required: 'optional',
          default: 'opendkim'

attribute 'opendkim/group',
          display_name: 'opendkim group',
          description: 'OpenDKIM system group.',
          type: 'string',
          required: 'optional',
          default: 'opendkim'
