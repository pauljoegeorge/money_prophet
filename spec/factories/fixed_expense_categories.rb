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