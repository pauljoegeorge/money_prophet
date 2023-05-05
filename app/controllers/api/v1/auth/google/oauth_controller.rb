# frozen_string_literal: true

module Api
  module V1
    module Auth
      module Google
        class OauthController < ApplicationController
          skip_before_action :authenticate_request, only: %i[google_auth google_auth_callback]
          def google_auth
            auth_url = ::Google::AuthClient.google_auth_url
            render json: { url: auth_url }
          end

          def google_auth_callback
            code = params[:code]
            access_token = ::Google::AuthClient.get_google_access_token(code)
            user_info = ::Google::AuthClient.get_google_user_info(access_token)

            @user = User.from_omniauth(user_info)
            return unless @user.persisted?

            bypass_sign_in(@user)
            token = JsonWebToken.encode(user_id: @user.id)
            render json: { token: token }
          end
        end
      end
    end
  end
end
