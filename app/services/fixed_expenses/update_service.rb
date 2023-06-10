# frozen_string_literal: true

module FixedExpenses
  class UpdateService
    attr_reader :current_user, :from, :amount

    def initialize(current_user, params)
      @current_user = current_user
      @from = params[:from].to_date.beginning_of_month
      @amount = params[:expenses]&.dig(0, :amount) || 0
    end

    def execute
      update_fixed_expense
      success
    rescue StandardError => e
      error(e.message)
    end

    private

    def update_fixed_expense
      fixed_expense = current_user.fixed_expenses.find_by(apply_from: from)
      if fixed_expense.present?
        fixed_expense.update(amount: amount)
      else
        current_user.fixed_expenses.create(
          apply_from: from,
          amount: amount,
          fixed_expense_category: current_user.fixed_expense_categories.first
        )
      end
    end

    def success
      OpenStruct.new(success?: true, data: current_user.fixed_expenses.of_month(from), status: :ok)
    end

    def error(message)
      OpenStruct.new(success?: false, error: message, status: :internal_server_error)
    end
  end
end
