# frozen_string_literal: true

module UnexpectedExpenses
  class UpdateService
    attr_reader :current_user, :from, :amount

    def initialize(current_user, params)
      @current_user = current_user
      @from = params[:from].to_date.beginning_of_month
      @amount = params[:expenses]&.dig(0, :amount) || 0
    end

    def execute
      update_unexpected_expense
      success
    rescue StandardError => e
      error(e.message)
    end

    private

    def update_unexpected_expense
      unexpected_expense = current_user.unexpected_expenses.of_month(from).first
      if unexpected_expense.present?
        unexpected_expense.update(amount: amount)
      else
        current_user.unexpected_expenses.create(
          apply_in: from,
          amount: amount,
          unexpected_expense_category: current_user.unexpected_expense_categories.first
        )
      end
    end

    def success
      OpenStruct.new(success?: true, data: current_user.unexpected_expenses.of_month(from), status: :ok)
    end

    def error(message)
      OpenStruct.new(success?: false, error: message, status: :internal_server_error)
    end
  end
end
