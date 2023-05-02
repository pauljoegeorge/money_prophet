class ExpenseSerializer < ActiveModel::Serializer
  def initialize(user, options = {})
    super
    @date = options[:date] || Time.zone.beginning_of_month
  end

  def fixed_expenses
    object.fixed_expenses.of_month(@date)
  end

  def unexpected_expenses
    object.unexpected_expenses.of_month(@date)
  end

  has_many :fixed_expenses, serializer: FixedExpenseSerializer
  has_many :unexpected_expenses, serializer: UnexpectedExpenseSerializer
end
