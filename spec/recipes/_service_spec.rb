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

describe 'opendkim::_service', order: :random do
  let(:chef_run) { chef_runner.converge(described_recipe) }

  {
    'CentOS@6.6'   => { status: true,  service: 'opendkim'         },
    'Fedora@20'    => { status: true,  service: 'opendkim'         },
    'Debian@6.0.5' => { status: false, service: 'opendkim'         },
    'Debian@7.8'   => { status: true,  service: 'opendkim'         },
    'Ubuntu@10.04' => { status: false, service: 'opendkim'         },
    'Ubuntu@12.04' => { status: true,  service: 'opendkim'         },
    'FreeBSD@10.0' => { status: true,  service: 'milter-opendkim'  }
  }.each do |platform, info|
    name, version = platform.split('@', 2)
    context "on #{name} #{version}" do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(platform: name.downcase, version: version)
      end

      it 'enables opendkim service' do
        expect(chef_run).to enable_service(info[:service])
      end

      it 'starts opendkim service' do
        expect(chef_run).to start_service(info[:service])
      end

      it "service status support: #{info[:status].inspect}" do
        min_support = Mash.new(restart: true, reload: true)
        expect(chef_run).to enable_service(info[:service])
          .with_supports(min_support.merge(status: info[:status]))
      end
    end # context on name version
  end # each platform
end
