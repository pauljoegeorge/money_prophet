# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
10.times do |i|
  user = User.find_by(name: "user_#{i}")
  next if user.present?

  user = User.create(name: "user_#{i}")

  %w[spotify rent aws].each_with_index do |fixed_expense, index|
    category = user.fixed_expense_categories.find_or_create_by(name: fixed_expense)
    user.fixed_expenses.create(
      amount: 100 * (i + 10 + index),
      apply_from: Time.zone.today.beginning_of_month,
      fixed_expense_category: category
    )
  end

  %w[taxi nitori].each_with_index do |unexpected_expense, index|
    category = user.unexpected_expense_categories.find_or_create_by(name: unexpected_expense)
    user.unexpected_expenses.create(
      amount: 100 * (i + 1 + index),
      apply_in: Time.zone.today.beginning_of_month,
      unexpected_expense_category: category
    )
  end
end
