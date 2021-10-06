# frozen_string_literal: true

class ApplicationController < BaseController
  use Rack::JSONBodyParser

  use AdsController
end
