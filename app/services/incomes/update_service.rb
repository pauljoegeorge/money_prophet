# frozen_string_literal: true

module Incomes
  class UpdateService
    attr_reader :current_user, :from, :amount

    def initialize(current_user, params)
      @current_user = current_user
      @from = params[:from].to_date.beginning_of_month
      @amount = params[:incomes]&.dig(0, :amount) || 0
    end

    def execute
      update_incomes
      success
    rescue StandardError => e
      error(e.message)
    end

    private

    def update_incomes
      income = current_user.incomes.of_month(from).first
      if income.present?
        income.update(amount: amount)
      else
        current_user.incomes.create(
          apply_from: from,
          amount: amount,
          income_source: current_user.income_sources.first
        )
      end
    end

    def success
      OpenStruct.new(success?: true, data: current_user.incomes.of_month(from), status: :ok)
    end

    def error(message)
      OpenStruct.new(success?: false, error: message, status: :internal_server_error)
    end
  end
end
