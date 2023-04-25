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
FactoryBot.define do
  factory :fixed_expense_category do
    name { "rent" }
    association :user
  end

  trait :with_fixed_expense do
    transient do
      amount { 100 }
    end

    after(:create) do |category, evaluator|
      create(
        :fixed_expense,
        fixed_expense_category: category,
        user: category.user,
        amount: evaluator.amount
      )
    end
  end
end
