# frozen_string_literal: true

class BankBalanceForecast < ApplicationRecord
  include Uid

  belongs_to :user

  scope :of_month, lambda { |date|
    where(date: date)
  }
end
