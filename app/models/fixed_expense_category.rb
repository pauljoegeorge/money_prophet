# == Schema Information
#
# Table name: fixed_expense_categories
#
#  id         :bigint           not null, primary key
#  uid        :string(255)      default(""), not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
class FixedExpenseCategory < ApplicationRecord
  include Uid

  has_many :fixed_expenses

  belongs_to :user
end
