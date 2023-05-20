# RUN: rake "user:create_expenses[#{user_id}]"
namespace :user do
  desc "create dummy expenses"
  task :create_expenses, [:user_id] => :environment do |a, args|
    user = User.find(args[:user_id])
    next if user.blank?
    next if user.fixed_expenses.where(apply_from: Time.zone.today.beginning_of_month).present?
    next if user.unexpected_expenses.of_month(Time.zone.today.beginning_of_month).present?

    STDOUT.puts "========== creating fixed expenses ==========="
    %w[spotify rent aws].each_with_index do |fixed_expense, index|
      category = user.fixed_expense_categories.find_or_create_by(name: fixed_expense)
      user.fixed_expenses.create(
        amount: 100 * (user.id + 10 + index),
        apply_from: Time.zone.today.beginning_of_month,
        fixed_expense_category: category
      )
    end

    STDOUT.puts "========== creating unexpected expenses ==========="
    %w[taxi nitori].each_with_index do |unexpected_expense, index|
      category = user.unexpected_expense_categories.find_or_create_by(name: unexpected_expense)
      user.unexpected_expenses.create(
        amount: 100 * (user.id + 1 + index),
        apply_in: Time.zone.today.beginning_of_month,
        unexpected_expense_category: category
      )
    end
  end

  task :create_income, [:user_id] => :environment do |a, args|
    user = User.find(args[:user_id])
    next if user.blank?
    next if user.incomes.where(apply_from: Time.zone.today.beginning_of_month).present?

    source = user.income_sources.find_or_create_by(source: "salary")
    user.incomes.create(
      amount: 1000 * (user.id + 1),
      apply_from: Time.zone.today.beginning_of_month,
      income_source: source
    )
  end
end
