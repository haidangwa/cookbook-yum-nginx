# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/deprecations'
require_relative 'shared_contexts'

ChefSpec::Coverage.start!

RSpec.configure do |config|
  config.platform = 'redhat'
  config.version = '7.4'
  config.include_context 'rpmquery'
end
