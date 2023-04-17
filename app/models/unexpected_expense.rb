class UnexpectedExpense < ApplicationRecord
  include Uid

  belongs_to :unexpected_expense_category
  belongs_to :user

  accepts_nested_attributes_for :unexpected_expense_category
end
