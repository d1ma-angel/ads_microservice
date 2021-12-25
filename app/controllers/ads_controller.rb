# frozen_string_literal: true

class AdsController < BaseController
  include Concerns::Auth
  include Concerns::Geocode
  include Concerns::PaginationLinks

  get '/?' do
    ads = Ad.order(updated_at: :desc).page(params[:page])
    serializer = AdSerializer.new(ads, links: pagination_links(ads))

    json serializer.serializable_hash
  end

  post '/?' do
    required_params 'ad' => %w[title description city]

    result = Ads::CreateService.call(
      user_id: user_id,
      ad: params[:ad],
      coordinates: { lat: coordinates[0], lon: coordinates[1] }
    )

    if result.success?
      serializer = AdSerializer.new(result.ad)

      status 201
      json serializer.serializable_hash
    else
      error_response(result.ad, 422)
    end
  end
end
