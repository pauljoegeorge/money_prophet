# frozen_string_literal: true

module BankBalances
  module Update
    extend ActiveSupport::Concern

    included do
      after_create :update_bank_balance
      after_update :update_bank_balance
    end

    private

    # called when income/expense is updated
    def update_bank_balance
      current_month = Time.zone.today.beginning_of_month
      self_date = instance_of?(::UnexpectedExpense) ? apply_in : apply_from
      return if self_date < current_month

      forecast = user.bank_balance_forecasts.of_month(current_month - 1.month).first

      update_forecasts(current_month, forecast&.amount&.presence || 0)
    end

    def update_forecasts(current_month, initial_balance)
      bank_balance = initial_balance
      12.times do |i|
        bank_balance += user.savings_of_month(current_month + i.month)
        user.bank_balance_forecasts.find_by(date: current_month + i.month)&.update(amount: bank_balance)
      end
    end
  end
end
