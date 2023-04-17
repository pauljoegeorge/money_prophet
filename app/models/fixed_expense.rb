class FixedExpense < ApplicationRecord
  include Uid

  belongs_to :fixed_expense_category
  belongs_to :user

  accepts_nested_attributes_for :fixed_expense_category
end