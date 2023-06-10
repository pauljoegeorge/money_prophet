# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_balance_forecasts
#
#  id         :bigint           not null, primary key
#  uid        :string(255)
#  date       :date             not null
#  amount     :integer          default(0), not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BankBalanceForecast < ApplicationRecord
  include Uid

  belongs_to :user

  scope :of_month, lambda { |date|
    where(date: date)
  }
end
