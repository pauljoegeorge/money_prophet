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
    current_user.fixed_expenses.of_month(from)
  end
end
