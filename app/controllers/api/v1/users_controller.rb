# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # TODO; remove it
      def index
        render json: { name: current_user.name }, status: :ok
      end
    end
  end
end
