# encoding: UTF-8
#
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

require 'spec_helper'

describe 'opendkim::default', order: :random do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }

  %w(
    user
    from_package
    configuration
    service
  ).each do |local_recipe|
    it "includes opendkim::_#{local_recipe} recipe" do
      expect(chef_run).to include_recipe("opendkim::_#{local_recipe}")
    end
  end # each local_recipe
end
