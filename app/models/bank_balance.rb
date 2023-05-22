class BankBalance < ApplicationRecord
  include Uid

  belongs_to :user

  scope :of_month, lambda { |date, user_id|
    record = find_by(date: date)
    if record.present?
      record
    else
      user = User.find(user_id)
      last_bank_balance = user.bank_balances.last
      balance = last_bank_balance&.amount || 0
      start_date = last_bank_balance&.date.present? ? last_bank_balance.date + 1.month : Time.zone.today.beginning_of_month
      end_date = date

      while start_date <= end_date
        balance += user.savings_of_month(start_date)
        user.bank_balances.create(amount: balance, date: start_date)

        start_date = start_date.next_month.at_beginning_of_month
      end
      find_by(date: date)
    end
  }
end
