class FixedExpenseCategory < ApplicationRecord
  include Uid

  has_many :fixed_expenses

  belongs_to :user
end