# frozen_string_literal: true

module Api
  module V1
    class IncomesController < ApplicationController
      before_action :validate!

      def index
        from = index_params[:from].to_date.beginning_of_month
        render json: current_user.incomes.of_month(from), status: :ok
      end

      def update
        result = Incomes::UpdateService.new(current_user, update_params).execute
        render json: result.data || result.error, status: result.status
      end

      private

      def index_params
        params.permit(
          :from
        )
      end

      def update_params
        params.permit(
          :from,
          incomes: %i[amount name]
        )
      end

      def validate!
        return true if params[:from].to_date.beginning_of_month >= Time.zone.today.beginning_of_month

        json_response({}, :unprocessable_entity)
      end
    end
  end
end
