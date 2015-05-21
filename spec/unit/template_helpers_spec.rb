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
require 'template_helpers.rb'

describe OpendkimCookbook::TemplateHelpers, order: :random do
  let(:helpers_class) do
    klass = Class.new
    klass.send(:include, described_class)
    klass
  end
  let(:helpers) { helpers_class.new }

  context '#value_to_s' do
    {
      true => 'true',
      'string' => 'string',
      [1, 'string', { a: 1 }] => '1,string,a=1',
      { a: 1, 'b' => '2', 'c' => [3, '4'] } => 'a=1,b=2,c=3,4'
    }.each do |value, result|
      it "returns #{result.inspect} for #{value.inspect}" do
        expect(helpers.value_to_s(value)).to eq(result)
      end
    end # each value, string
  end # context #value_to_s
end
