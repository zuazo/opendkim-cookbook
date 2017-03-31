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

family = os[:family].downcase

opendkim_testmsg =
  if %w(redhat centos fedora scientific amazon).include?(family)
    '/usr/sbin/opendkim-testmsg'
  else
    'opendkim-testmsg'
  end

dkim_test_message = <<-EOH
  Date: Wed, 29 Jan 2015 10:15:11 +0000 (UTC)
  From: Bob <bob@example.com>
  To: Alice <alice@example.com>
  Subject: Testing DKIM

  Testing DKIM body message.
EOH

dkim_test_command =
  "#{opendkim_testmsg} -d example.com -s mail -k "\
  '/etc/opendkim/keys/example.com/mail.private'

if system("which #{dkim_test_command}")
  describe command("echo '#{dkim_test_message}' | #{dkim_test_command}") do
    its(:exit_status) { should eq 0 }
    its(:stdout) do
      should contain(/^DKIM-Signature: .* d=example.com; s=mail;/)
    end
  end
end
