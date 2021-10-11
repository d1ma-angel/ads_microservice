# frozen_string_literal: true

RACK_ENV = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

require 'bundler'
Bundler.require(:default, RACK_ENV.to_sym)

loader = Zeitwerk::Loader.new
%w[
  app/controllers
  app/errors
  app/models
  app/serializers
  app/services
].each { |path| loader.push_dir(path) }
loader.setup

I18n.load_path << Dir["#{File.expand_path('config/locales')}/**/*.yml"]
I18n.config.available_locales = %i[en ru]
I18n.default_locale = :ru
