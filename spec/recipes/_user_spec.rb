# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@onddo.com>)
# Copyright:: Copyright (c) 2015 Onddo Labs, SL. (www.onddo.com)
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

require 'spec_helper'

describe 'opendkim::_user', order: :random do
  let(:chef_runner) { ChefSpec::ServerRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:home_dir) { '/var/run/opendkim' }

  it 'creates home directory' do
    expect(chef_run).to create_directory(home_dir)
      .with_owner('opendkim')
      .with_group('opendkim')
      .with_mode('00755')
  end

  it 'create opendkim user' do
    expect(chef_run).to create_user('opendkim')
      .with_comment('OpenDKIM user')
      .with_home(home_dir)
      .with_shell('/bin/false')
      .with_system(true)
  end

  it 'create opendkim group' do
    expect(chef_run).to create_group('opendkim')
      .with_members(%w(opendkim))
      .with_system(true)
      .with_append(true)
  end
end
