# frozen_string_literal: true

RACK_ENV = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

require 'rubygems'
require 'bundler'

Bundler.require(:default, RACK_ENV.to_sym)

LOADER = Zeitwerk::Loader.new
%w[
  app/controllers
  app/errors
  app/models
  app/serializers
  app/services
].each { |path| LOADER.push_dir(path) }
LOADER.setup

I18n.load_path << Dir["#{File.expand_path('config/locales')}/**/*.yml"]
I18n.config.available_locales = %i[en ru]
I18n.default_locale = :ru
