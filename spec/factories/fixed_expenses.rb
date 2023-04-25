FactoryBot.define do
  factory :fixed_expense do
    apply_from { Date.today.beginning_of_month }
    amount { 0 }
    association :user
    association :fixed_expense_category
  end
end