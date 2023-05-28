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
class User < ApplicationRecord
  has_secure_password

  attr_accessor :password_digest

  include Uqid
  include InitCategory

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true

  has_many :fixed_expenses, dependent: :destroy
  has_many :fixed_expense_categories, dependent: :destroy
  has_many :unexpected_expenses, dependent: :destroy
  has_many :unexpected_expense_categories, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :income_sources, dependent: :destroy
  has_many :bank_balance_forecasts, dependent: :destroy

  def self.from_omniauth(response)
    where(uid: response["id"]).first_or_create do |u|
      u.uid = response["id"]
      u.name = response["name"]
      u.email = response["email"]
      u.password = SecureRandom.hex(15)
    end
  end

  def savings_of_month(date)
    income = incomes.total_of_month(date)
    expenses = fixed_expenses.total_of_month(date) + unexpected_expenses.total_of_month(date)
    income - expenses
  end

  def create_pending_balance_forecasts
    current_month = Time.zone.now.beginning_of_month
    end_month = current_month + 12.months
    return if bank_balance_forecasts.find_by(date: end_month)

    init_pending_balance_forecasts(current_month, end_month)
  end

  private

  def init_pending_balance_forecasts(current_month, end_month)
    last_available_forecast = bank_balance_forecasts.last
    last_balance = last_available_forecast&.amount || 0
    start_date = if last_available_forecast&.date.present?
                   last_available_forecast.date + 1.month
                 else
                   current_month
                 end

    while start_date <= end_month
      last_balance += savings_of_month(start_date)
      bank_balance_forecasts.create(amount: last_balance, date: start_date)
      start_date = start_date.next_month.at_beginning_of_month
    end
  end
end
