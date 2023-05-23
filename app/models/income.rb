# frozen_string_literal: true

# == Schema Information
#
# Table name: incomes
#
#  id               :bigint           not null, primary key
#  uid              :string(255)      default(""), not null
#  apply_from       :date             not null
#  amount           :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  income_source_id :bigint           not null
#  user_id          :bigint           not null
#
class Income < ApplicationRecord
  include Uid
  include BankBalances::Update

  belongs_to :income_source
  belongs_to :user

  accepts_nested_attributes_for :income_source

  delegate :source, to: :income_source

  scope :of_month, lambda { |date|
    where("apply_from <= ?", date.beginning_of_month)
      .order(income_source_id: :asc, apply_from: :desc)
      .group_by(&:income_source_id)
      .map { |_, records| records.first }
  }

  scope :total_of_month, lambda { |month|
    of_month(month).map(&:amount).sum || 0
  }
end
