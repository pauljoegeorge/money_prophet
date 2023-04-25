# frozen_string_literal: true

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
FactoryBot.define do
  factory :fixed_expense do
    apply_from { Time.zone.today.beginning_of_month }
    amount { 0 }
    association :user
    association :fixed_expense_category
  end
end
