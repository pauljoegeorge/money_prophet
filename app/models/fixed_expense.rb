# == Schema Information
#
# Table name: fixed_expenses
#
#  id                        :bigint           not null, primary key
#  uid                       :string(255)      default(""), not null
#  apply_from                :date             not null
#  amount                    :integer          default(0)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fixed_expense_category_id :bigint           not null
#  user_id                   :bigint           not null
#
class FixedExpense < ApplicationRecord
  include Uid

  belongs_to :fixed_expense_category
  belongs_to :user

  accepts_nested_attributes_for :fixed_expense_category
end
