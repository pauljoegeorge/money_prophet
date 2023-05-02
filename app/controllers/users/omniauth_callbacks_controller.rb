# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_request, only: [:google_oauth2]
    skip_before_action :verify_authenticity_token, raise: false

    def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])
      return unless @user.persisted?

      sign_in_and_render_json_response
    end

    def sign_in_and_render_json_response
      sign_in(@user, event: :authentication, bypass: true)
      token = ::JsonWebToken.encode(user_id: @user.id)
      render json: { message: "Signed in successfully", token: token }
    end

    def failure
      render json: { errors: ["Authentication failed"] }, status: :unprocessable_entity
    end
  end
end
