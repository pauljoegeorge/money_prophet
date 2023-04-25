# frozen_string_literal: true

# == Schema Information
#
# Table name: unexpected_expense_categories
#
#  id         :bigint           not null, primary key
#  uid        :string(255)      default(""), not null
#  name       :string(255)      default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
class UnexpectedExpenseCategory < ApplicationRecord
  include Uid

  has_many :unexpected_expenses, dependent: :destroy

  belongs_to :user, dependent: :destroy
end
