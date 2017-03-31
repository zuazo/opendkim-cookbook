# Cookbook Name:: opendkim
# Attributes:: default
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

case node['platform_family']
when 'rhel'
  default['opendkim']['conf_file'] = '/etc/opendkim.conf'
  default['opendkim']['service']['name'] = 'opendkim'
  default['opendkim']['service']['supports'] =
    { restart: true, reload: true, status: true }
  default['opendkim']['packages']['tools'] = []
when 'fedora'
  default['opendkim']['conf_file'] = '/etc/opendkim.conf'
  default['opendkim']['service']['name'] = 'opendkim'
  default['opendkim']['service']['supports'] =
    { restart: true, reload: true, status: true }
  default['opendkim']['packages']['tools'] = []
when 'debian'
  default['opendkim']['conf_file'] = '/etc/opendkim.conf'
  default['opendkim']['service']['name'] = 'opendkim'
  case node['platform']
  when 'debian', 'raspbian'
    if node['platform_version'].to_i < 7
      default['opendkim']['service']['supports'] =
        { restart: true, reload: true, status: false }
      default['opendkim']['packages']['tools'] = []
    else
      default['opendkim']['service']['supports'] =
        { restart: true, reload: true, status: true }
      default['opendkim']['packages']['tools'] = %w(opendkim-tools)
    end
  when 'ubuntu'
    if node['platform_version'].to_i < 12
      default['opendkim']['service']['supports'] =
        { restart: true, reload: true, status: false }
      default['opendkim']['packages']['tools'] = []
    else
      default['opendkim']['service']['supports'] =
        { restart: true, reload: true, status: true }
      default['opendkim']['packages']['tools'] = %w(opendkim-tools)
    end
  end
when 'openbsd', 'freebsd', 'mac_os_x'
  default['opendkim']['conf_file'] = '/usr/local/etc/mail/opendkim.conf'
  default['opendkim']['packages']['tools'] = []
  default['opendkim']['service']['name'] = 'milter-opendkim'
  default['opendkim']['service']['supports'] =
    { restart: true, reload: true, status: true }
else
  default['opendkim']['conf_file'] = '/etc/opendkim.conf'
  default['opendkim']['packages']['tools'] = %w(opendkim-tools)
  default['opendkim']['service']['name'] = 'opendkim'
  default['opendkim']['service']['supports'] =
    { restart: true, reload: true, status: true }
end
default['opendkim']['packages']['service'] = %w(opendkim)
default['opendkim']['run_dir'] = '/var/run/opendkim'
default['opendkim']['user'] = 'opendkim'
default['opendkim']['group'] = node['opendkim']['user']

default['opendkim']['conf'] = Mash.new

# Name of the file where the filter should write its pid before beginning
# normal operations.
default['opendkim']['conf']['PidFile'] =
  ::File.join(node['opendkim']['run_dir'], 'opendkim.pid')

# Create a socket through which your MTA can communicate.
# Names the socket where this filter should listen for milter connections from
# the MTA. Required. Should be in one of these forms:
#
# inet:port@address           to listen on a specific interface
# inet:port                   to listen on all interfaces
# local:/path/to/socket       to listen on a UNIX domain socket
default['opendkim']['conf']['Socket'] = 'inet:8891@localhost'

# Change to user "userid" before starting normal operation. May include a group
# ID as well, separated from the userid by a colon.
default['opendkim']['conf']['UserID'] =
  "#{node['opendkim']['user']}:#{node['opendkim']['group']}"
