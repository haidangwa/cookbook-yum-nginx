# frozen_string_literal: true

require 'spec_helper'

# the assumption made here is that if there is a source repo present, then the
#  the source package was downloaded successfully
describe command('yum repolist -v nginx-stable-source') do
  its(:exit_status) { should eq 0 }
end
