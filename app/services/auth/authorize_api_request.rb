# frozen_string_literal: true

module Auth
  class AuthorizeApiRequest
    def initialize(headers = {})
      @headers = headers
    end

    def self.call(headers)
      new(headers).call
    end

    def call
      user
    end

    private

    attr_reader :headers

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue StandardError
      raise ExceptionHandler::Unauthorized
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      return headers["Authorization"].split(" ").last if headers["Authorization"].present?

      raise ExceptionHandler::Unauthorized
    end
  end
end
