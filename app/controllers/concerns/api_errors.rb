# frozen_string_literal: true

module Concerns
  module ApiErrors
    private

    def handle_exception(err)
      case err
      when ActiveRecord::RecordNotFound
        error_response(I18n.t(:not_found, scope: 'api.errors'), 404)
      when ActiveRecord::RecordNotUnique
        error_response(I18n.t(:not_unique, scope: 'api.errors'), 422)
      when RequiredParamMissing
        error_response(I18n.t(:missing_parameters, scope: 'api.errors'), 422)
      else
        raise
      end
    end

    def error_response(error_messages, status)
      errors = case error_messages
               when ActiveRecord::Base
                 ErrorSerializer.from_model(error_messages)
               else
                 ErrorSerializer.from_messages(error_messages)
               end

      halt status, errors.to_json
    end
  end
end
