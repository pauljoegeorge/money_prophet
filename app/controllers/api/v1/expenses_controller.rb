# frozen_string_literal: true

module Api
  module V1
    class ExpensesController < ApplicationController
      before_action :validate!
      before_action :init_balance_forecasts, only: %w[index]

      def index
        forecast = Balance::GetForecastService.new(current_user).execute
        render json: ExpenseSerializer.new(
          current_user, date: index_params[:from].to_date.beginning_of_month, forecast: forecast.data
        ).to_json, status: :ok
      end

      private

      def index_params
        params.permit(
          :from
        )
      end

      def validate!
        return true if params[:from].to_date.beginning_of_month >= Time.zone.today.beginning_of_month

        json_response({}, :unprocessable_entity)
      end

      def init_balance_forecasts
        current_user.create_pending_balance_forecasts
      end
    end
  end
end
