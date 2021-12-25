# frozen_string_literal: true

module GeocoderService
  module Api
    def geocode(city)
      response = connection.post('geocode', city: city)

      response.body if response.success?
    end
  end
end
