# encoding: UTF-8
#
# Cookbook Name:: opendkim_test
# Recipe:: default
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

dkey_domain = 'example.com'

# Log informational and error activity to syslog.
node.default['opendkim']['conf']['Syslog'] = true
# Change the process umask for file creation to the specified value. The system
# has its own default which will be used (usually 022). See the umask(2) man
# page for more information.
node.default['opendkim']['conf']['UMask'] = '002'

# Always oversign From (sign using actual From and a null From to prevent
# malicious signatures header fields (From and/or others) between the signer
# and the verifier. From is oversigned by default because it is often the
# identity key used by reputation systems and thus somewhat security sensitive.
unless (node['platform'] == 'debian' && node['platform_version'].to_i < 7) ||
       (node['platform'] == 'ubuntu' && node['platform_version'].to_i < 12)
  node.default['opendkim']['conf']['OversignHeaders'] = 'From'
end

# Indicates which mode(s) of operation should be provided. "s" means "sign",
# "v" means "verify".
node.default['opendkim']['conf']['Mode'] = 'sv'

# Log success activity to syslog.
node.default['opendkim']['conf']['SyslogSuccess'] = true

# Causes the library not to accept signatures matching keys made of fewer than
# the specified number of bits, even if they would otherwise pass DKIM signing.
unless (node['platform'] == 'debian' && node['platform_version'].to_i < 7) ||
       (node['platform'] == 'ubuntu' && node['platform_version'].to_i < 12)
  node.default['opendkim']['conf']['MinimumKeyBits'] = '1024'
end

# Defines a table that will be queried to convert key names to sets of data of
# the form (signing domain, signing selector, private key). The private key can
# either contain a PEM-formatted private key, a base64-encoded DER format
# private key, or a path to a file containing one of those.
key_table_default = node.default['opendkim']['conf']['KeyTable']
key_table_default["csl:mail._domainkey.#{dkey_domain}"] =
  "#{dkey_domain}:mail:/etc/opendkim/keys/#{dkey_domain}/mail.private"

# Defines a dataset that will be queried for the message sender's address
# to determine which private key(s) (if any) should be used to sign the
# message. The sender is determined from the value of the sender
# header fields as described with SenderHeaders above. The key for this
# lookup should be an address or address pattern that matches senders;
# see the opendkim.conf(5) man page for more information. The value
# of the lookup should return the name of a key found in the KeyTable
# that should be used to sign the message. If MultipleSignatures
# is set, all possible lookup keys will be attempted which may result
# in multiple signatures being applied.
signing_table_default = node.default['opendkim']['conf']['SigningTable']
signing_table_default["csl:*@#{dkey_domain}"] = "mail._domainkey.#{dkey_domain}"

include_recipe 'opendkim'

directory "/etc/opendkim/keys/#{dkey_domain}" do
  owner node['opendkim']['user']
  group node['opendkim']['group']
  recursive true
end

cookbook_file "/etc/opendkim/keys/#{dkey_domain}/mail.private" do
  owner node['opendkim']['user']
  group node['opendkim']['group']
  mode '00640'
end

cookbook_file "/etc/opendkim/keys/#{dkey_domain}/mail.txt" do
  owner node['opendkim']['user']
  group node['opendkim']['group']
  mode '00644'
end

# Required for integration tests:
package 'lsof'
include_recipe 'netstat'
node['opendkim']['packages']['tools'].each { |pkg| package pkg }
