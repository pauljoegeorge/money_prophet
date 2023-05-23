# frozen_string_literal: true

module BankBalances
  module Update
    extend ActiveSupport::Concern

    included do
      after_create :update_bank_balance
      after_update :update_bank_balance
    end

    private

    def update_bank_balance
      current_month = Time.zone.today.beginning_of_month
      bank_balance = user.bank_balances.of_month(current_month, user.id).amount

      12.times do |i|
        bank_balance += user.savings_of_month(current_month + i.month)
        user.bank_balances.find_by(date: current_month + i.month)&.update(amount: bank_balance)
      end
    end
  end
end
