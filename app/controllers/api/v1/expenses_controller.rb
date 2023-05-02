# frozen_string_literal: true

module Api
  module V1
    class ExpensesController < ApplicationController
      before_action :validate!

      def index
        render json: ExpenseSerializer.new(current_user, date: index_params[:from].to_date.beginning_of_month).to_json,
               status: :ok
      end

      private

      def index_params
        params.permit(
          :from
        )
      end

      def validate!
        return true if params[:from]

        render json: {}, status: :unprocessable_entity
      end
    end
  end
end
