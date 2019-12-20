# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rake'

# style
gem 'cookstyle', '~> 5.16.11'

# unit
gem 'berkshelf', '~> 7.0.7'
gem 'chefspec', '~> 9.0.0'
gem 'rspec'

# integration
gem 'serverspec'
gem 'test-kitchen', '~> 2.3.4'

group :'local-integration' do
  gem 'kitchen-dokken', '~> 2.8.1'
  gem 'kitchen-vagrant', '~> 1.6.0'
end

# publish
gem 'stove', '~> 7.1.5'
