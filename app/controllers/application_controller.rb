# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies
  include Response
  include ExceptionHandler

  before_action :authenticate_request
  attr_reader :current_user

  def authenticate_request
    @current_user = Auth::AuthorizeApiRequest.call(request.headers)
    render json: { error: "Not Authorized" }, status: :unauthorized unless @current_user
  end
end
