# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  name                   :string(255)
#  uid                    :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  password_digest        :string(255)
#  uqid                   :string(255)      not null
#
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
