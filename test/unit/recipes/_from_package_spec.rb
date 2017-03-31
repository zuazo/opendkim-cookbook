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

require_relative '../spec_helper'

describe 'opendkim::_from_package', order: :random do
  let(:chef_run) { chef_runner.converge(described_recipe) }

  context 'on CentOS' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.6')
    end

    it 'includes yum-epel recipe' do
      expect(chef_run).to include_recipe('yum-epel')
    end

    it 'installs opendkim' do
      expect(chef_run).to install_package('opendkim')
    end
  end # context on CentOS

  context 'on Fedora' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'fedora', version: '24')
    end

    it 'does not include yum-epel recipe' do
      expect(chef_run).to_not include_recipe('yum-epel')
    end

    it 'installs opendkim' do
      expect(chef_run).to install_package('opendkim')
    end
  end # context on Fedora

  context 'on Debian' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'debian', version: '7.6')
    end

    it 'does not include yum-epel recipe' do
      expect(chef_run).to_not include_recipe('yum-epel')
    end

    it 'installs opendkim' do
      expect(chef_run).to install_package('opendkim')
    end
  end # context on Debian

  context 'on Ubuntu' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
    end

    it 'does not include yum-epel recipe' do
      expect(chef_run).to_not include_recipe('yum-epel')
    end

    it 'installs opendkim' do
      expect(chef_run).to install_package('opendkim')
    end
  end # context on Ubuntu

  context 'on FreeBSD' do
    let(:chef_runner) do
      ChefSpec::SoloRunner.new(platform: 'freebsd', version: '11.0')
    end

    it 'does not include yum-epel recipe' do
      expect(chef_run).to_not include_recipe('yum-epel')
    end

    it 'installs opendkim' do
      expect(chef_run).to install_package('opendkim')
    end
  end # context on FreeBSD
end
