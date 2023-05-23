# frozen_string_literal: true

module FixedExpenses
  class CreateOrUpdateExpensesService
    attr_reader :current_user, :from, :amount

    def initialize(current_user, params)
      @current_user = current_user
      @from = params[:from].to_date.beginning_of_month
      @amount = params[:amount] || 0
    end
  end

  def execute
    fixed_expense = current_user.fixed_expenses.find_by(apply_from: from)
    if fixed_expense.present?
      fixed_expense.update(amount: amount)
    else
      current_user.fixed_expenses.create(apply_from: from, amount: amount)
    end
  end
end
