# frozen_string_literal: true

module Concerns
  module Geocode
    def coordinates
      coordinates = geocode_service.geocode(city)
      raise Unauthorized if coordinates.blank?

      coordinates
    end

    private

    def geocode_service
      @geocode_service ||= GeocoderService::Client.new
    end

    def city
      result = params.dig(:ad, :city)
      return if result.blank?

      result
    end
  end
end
