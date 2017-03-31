# Cookbook Name:: opendkim
# Library:: template_helpers
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

# `opendkim` internal classes.
module OpendkimCookbook
  # Some helpers to use from `opendkim` cookbook templates.
  #
  # @example
  #   self.class.send(:include, ::OpendkimCookbook::TemplateHelpers)
  #   value_to_s(true) #=> "true"
  #   value_to_s([1, 'string', { a: 1 }]) #=> "1,string,a=1"
  module TemplateHelpers
    # Converts a Ruby array to a configuration list separated by commas.
    #
    # @param ary [Array] array to convert.
    # @return [String] configuration value as string.
    # @example
    #   array_to_s([3, '4']) #=> "a=1,b=2,c=3,4"
    # @api private
    def array_to_s(ary)
      ary.map { |x| value_to_s(x) }.join(',')
    end

    # Converts a Ruby hash to a configuration list separated by commas.
    #
    # @param hs [Hash] hash to convert.
    # @return [String] configuration value as string.
    # @example
    #   hash_to_s({ a: 1, b: '2' }) #=> "a=1,b=2"
    # @api private
    def hash_to_s(hs)
      value_ary = hs.map { |k, v| "#{k}=#{value_to_s(v)}" }
      array_to_s(value_ary)
    end

    # Converts a Ruby configuration value to its string representation.
    #
    # @param v [Mixed] the configuration value.
    # @return [String] the configuration value as string.
    # @example
    #   value_to_s(true') #=> "true"
    #   value_to_s([1, 'string', { a: 1 }]) #=> "1,string,a=1"
    #   value_to_s({ a: 1, 'b' => '2', 'c' => [3, '4'] }) #=> "a=1,b=2,c=3,4"
    def value_to_s(v)
      case v
      when Array then array_to_s(v)
      when Hash then hash_to_s(v)
      else
        v.to_s
      end
    end
  end
end
