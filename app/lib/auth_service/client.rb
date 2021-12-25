# frozen_string_literal: true

module AuthService
  class Client
    include Api

    def initialize(url: nil, connection: nil)
      @url = url || 'http://localhost:3010/v1'
      @connection = connection || build_connection
    end

    private

    attr_reader :url, :connection

    def build_connection
      Faraday.new(@url) do |conn|
        conn.request :json
        conn.response :json, content_type: /\bjson$/
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
