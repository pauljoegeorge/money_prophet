# == Schema Information
#
# Table name: unexpected_expenses
#
#  id                             :bigint           not null, primary key
#  uid                            :string(255)      default(""), not null
#  apply_in                       :date             not null
#  amount                         :integer          default(0)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  unexpected_expense_category_id :bigint           not null
#  user_id                        :bigint           not null
#
class UnexpectedExpenseSerializer < ActiveModel::Serializer
  attributes :amount, :name
end
