# frozen_string_literal: true

class AdsController < BaseController
  include Concerns::ApiErrors
  include Concerns::PaginationLinks

  before do
    content_type :json
  end

  get '/?' do
    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads))

    serializer.serializable_hash.to_json
  end

  post '/?' do
    required_params ad: %i[title description city user_id]

    result = CreateService.call(params.deep_symbolize_keys)

    if result.success?
      serializer = AdSerializer.new(result.ad)

      status 201
      serializer.serializable_hash.to_json
    else
      error_response(result.ad, 422)
    end
  end
end
