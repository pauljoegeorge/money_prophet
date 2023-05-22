# frozen_string_literal: true

# == Schema Information
#
# Table name: fixed_expenses
#
#  id                        :bigint           not null, primary key
#  uid                       :string(255)      default(""), not null
#  apply_from                :date             not null
#  amount                    :integer          default(0)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  fixed_expense_category_id :bigint           not null
#  user_id                   :bigint           not null
#
class FixedExpense < ApplicationRecord
  include Uid

  belongs_to :fixed_expense_category
  belongs_to :user

  accepts_nested_attributes_for :fixed_expense_category

  delegate :name, to: :fixed_expense_category

  scope :of_month, lambda { |date|
    where("apply_from <= ?", date.beginning_of_month)
      .order(fixed_expense_category_id: :asc, apply_from: :desc)
      .group_by(&:fixed_expense_category_id)
      .map { |_, records| records.first }
  }

  scope :total_of_month, lambda { |month|
    of_month(month).map(&:amount).sum || 0
  }
end
