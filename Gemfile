# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '2.7.4'

gem 'dry-initializer'
gem 'i18n'
gem 'jsonapi-serializer'
gem 'kaminari'
gem 'pg'
gem 'puma'
gem 'rack-contrib', require: 'rack/contrib'
gem 'rake'
gem 'sinatra', require: %w[sinatra/base sinatra/reloader]
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'sinatra-contrib', require: %w[sinatra/required_params sinatra/json]
gem 'zeitwerk'

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'factory_bot'
  gem 'rack-test'
  gem 'rspec'
  gem 'database_cleaner-active_record'
end
