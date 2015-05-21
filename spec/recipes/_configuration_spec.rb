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

describe 'opendkim::_configuration', order: :random do
  let(:chef_runner) { ChefSpec::ServerRunner.new }
  let(:chef_run) { chef_runner.converge('opendkim::default') }
  let(:conf_file) { '/etc/opendkim.conf' }

  it 'creates opendkim.conf template' do
    expect(chef_run).to create_template(conf_file)
      .with_source('opendkim.conf.erb')
      .with_cookbook('opendkim')
      .with_mode('00644')
  end

  context 'opendkim.conf template' do
    let(:resource) { chef_run.template(conf_file) }

    it 'notifies opendkim service restart' do
      expect(resource).to notify('service[opendkim]').to(:restart).delayed
    end
  end

  context 'on FreeBSD' do
    let(:conf_file) { '/usr/local/etc/mail/opendkim.conf' }
    let(:chef_runner) do
      ChefSpec::ServerRunner.new(platform: 'freebsd', version: '10.0')
    end

    it 'creates opendkim.conf template' do
      expect(chef_run).to create_template(conf_file)
        .with_source('opendkim.conf.erb')
        .with_cookbook('opendkim')
        .with_mode('00644')
    end

    context 'opendkim.conf template' do
      let(:resource) { chef_run.template(conf_file) }

      it 'notifies opendkim service restart' do
        expect(resource)
          .to notify('service[milter-opendkim]').to(:restart).delayed
      end
    end
  end # context on FreeBSD
end
