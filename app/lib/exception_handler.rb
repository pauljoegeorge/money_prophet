# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class Unauthorized < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::MissingToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ExceptionHandler::InvalidToken do |e|
      json_response({ message: e.message }, :unauthorized)
    end

    rescue_from ExceptionHandler::Unauthorized do
      json_response({ message: "Unauthorized. Please login" }, :unauthorized)
    end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({ message: e.message, code: 400 }, :bad_request)
    end
  end
end
