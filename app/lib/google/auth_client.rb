# frozen_string_literal: true

require "faraday"
module Google
  class AuthClient
    CLIENT_ID = ENV["GOOGLE_CLIENT_ID"]
    CLIENT_SECRET = ENV["GOOGLE_CLIENT_SECRET"]
    REDIRECT_URI = ::Constants::GOOGLE_REDIRECT_URI

    def self.google_auth_url
      scope = "email profile"
      response_type = "code"

      "https://accounts.google.com/o/oauth2/auth?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&scope=#{scope}&response_type=#{response_type}&state=google"
    end

    def self.get_google_access_token(code)
      token_response = Faraday.post("https://oauth2.googleapis.com/token") do |req|
        req.params["code"] = code
        req.params["client_id"] = CLIENT_ID
        req.params["client_secret"] = CLIENT_SECRET
        req.params["redirect_uri"] = REDIRECT_URI
        req.params["grant_type"] = "authorization_code"
      end

      JSON.parse(token_response.body)["access_token"]
    end

    def self.get_google_user_info(access_token)
      user_info_response = Faraday.get("https://www.googleapis.com/oauth2/v1/userinfo?access_token=#{access_token}")
      JSON.parse(user_info_response.body)
    end
  end
end
