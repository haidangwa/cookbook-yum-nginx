# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rake'

# style
gem 'foodcritic', '~> 15.0.0'
gem 'rubocop', '~> 0.61.1'

# unit
gem 'berkshelf', '~> 7.0.7'
gem 'chefspec', '~> 7.3.3'
gem 'rspec'

# integration
gem 'serverspec'
gem 'test-kitchen', '~> 1.23.5'

group :'local-integration' do
  gem 'kitchen-docker', '~> 2.7.0'
  gem 'kitchen-vagrant', '~> 1.3.6'
end

# publish
gem 'stove', '~> 7.0.0'
