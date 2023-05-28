# frozen_string_literal: true

module InitCategory
  extend ActiveSupport::Concern

  included do
    after_create :create_expense_settings
  end

  private

  def create_expense_settings
    default_category_name = "overall"
    create_balance_forecasts
    create_fixed_expenses(default_category_name)
    create_unexpected_expenses(default_category_name)
    create_income_sources(default_category_name)
  end

  def create_balance_forecasts
    12.times do |i|
      bank_balance_forecasts.create(date: Time.zone.today.beginning_of_month + i.month, amount: 0)
    end
  end

  def create_fixed_expenses(default_category_name)
    fixed_expense_category = fixed_expense_categories.find_or_create_by(name: default_category_name)
    fixed_expenses.create(
      apply_from: Time.zone.today.beginning_of_month,
      fixed_expense_category: fixed_expense_category
    )
  end

  def create_unexpected_expenses(default_category_name)
    unexpected_expense_category = unexpected_expense_categories.find_or_create_by(name: default_category_name)
    unexpected_expenses.create(
      apply_in: Time.zone.today.beginning_of_month,
      unexpected_expense_category: unexpected_expense_category
    )
  end

  def create_income_sources(default_category_name)
    income_source = income_sources.find_or_create_by(source: default_category_name)
    incomes.create(
      apply_from: Time.zone.today.beginning_of_month,
      income_source: income_source
    )
  end
end
