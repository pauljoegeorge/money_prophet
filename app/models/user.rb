class User < ApplicationRecord
  include Uid

  has_many :fixed_expenses
  has_many :fixed_expense_categories
  has_many :unexpected_expenses
  has_many :unexpected_expense_categories
end