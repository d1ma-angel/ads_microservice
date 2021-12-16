require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../dependencies'

abort('You run tests in production mode. Please don\'t do this!') if RACK_ENV.to_sym == :production
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
end
