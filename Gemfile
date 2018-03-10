# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rake'

# style
gem 'foodcritic', '~> 12.2.2'
gem 'rubocop', '~> 0.51.0'

# unit
gem 'berkshelf', '~> 6.3.1'
gem 'chefspec', '~> 7.1.0'
gem 'rspec'

# integration
gem 'serverspec'
gem 'test-kitchen', '~> 1.19.2'

group :'local-integration' do
  gem 'kitchen-docker', '~> 2.6.0'
  gem 'kitchen-vagrant', '~> 1.3.1'
end

# publish
gem 'stove', '~> 6.0.0'
