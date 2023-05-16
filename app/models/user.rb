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

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true

  has_many :fixed_expenses, dependent: :destroy
  has_many :fixed_expense_categories, dependent: :destroy
  has_many :unexpected_expenses, dependent: :destroy
  has_many :unexpected_expense_categories, dependent: :destroy

  def self.from_omniauth(response)
    where(uid: response["id"]).first_or_create do |u|
      u.uid = response["id"]
      u.name = response["name"]
      u.email = response["email"]
      u.password = SecureRandom.hex(15)
    end
  end
end
