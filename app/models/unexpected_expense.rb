# frozen_string_literal: true

# == Schema Information
#
# Table name: unexpected_expenses
#
#  id                             :bigint           not null, primary key
#  uid                            :string(255)      default(""), not null
#  apply_in                       :date             not null
#  amount                         :integer          default(0)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  unexpected_expense_category_id :bigint           not null
#  user_id                        :bigint           not null
#
class UnexpectedExpense < ApplicationRecord
  include Uid
  include BankBalances::Update

  belongs_to :unexpected_expense_category
  belongs_to :user

  accepts_nested_attributes_for :unexpected_expense_category

  delegate :name, to: :unexpected_expense_category

  scope :of_month, lambda { |date|
    where(apply_in: date.beginning_of_month)
  }

  scope :total_of_month, lambda { |month|
    of_month(month).map(&:amount).sum || 0
  }
end
