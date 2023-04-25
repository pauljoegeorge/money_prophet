FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
  end

  trait :with_fixed_expenses do
    after(:create) do |user|
      %w[rent spotify aws].each_with_index do |category, index|
        create(
          :fixed_expense_category,
          :with_fixed_expense,
          name: category,
          amount: 100 * (index + 1),
          user: user
        )
      end
    end
  end
end