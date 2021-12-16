# frozen_string_literal: true

class BaseController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  helpers Sinatra::RequiredParams

  configure do
    set :title, 'Ads Component'
    set :server, 'puma'
  end

  configure :development do
    register Sinatra::Reloader
  end

  include Concerns::ApiErrors
  include Concerns::PaginationLinks

  error 400 do
    handle_exception(RequiredParamMissing.new)
  end

  error StandardError do |e|
    handle_exception(e)
  end
end
