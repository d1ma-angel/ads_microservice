# frozen_string_literal: true

module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :coordinates do
      option :lat
      option :lon
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(
        title: @ad.title,
        description: @ad.description,
        city: @ad.city,
        user_id: @user_id,
        lat: @coordinates.lat,
        lon: @coordinates.lon
      )
      return fail!(@ad.errors) unless @ad.save
    end
  end
end
