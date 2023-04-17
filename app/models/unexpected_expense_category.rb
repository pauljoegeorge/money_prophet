class UnexpectedExpenseCategory < ApplicationRecord
  include Uid

  has_many :unexpected_expenses

  belongs_to :user
end
