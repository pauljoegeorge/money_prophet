# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  uid        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  include Uid

  validates :name, presence: true

  has_many :fixed_expenses, dependent: :destroy
  has_many :fixed_expense_categories, dependent: :destroy
  has_many :unexpected_expenses, dependent: :destroy
  has_many :unexpected_expense_categories, dependent: :destroy
end
