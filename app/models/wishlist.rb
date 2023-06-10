# frozen_string_literal: true

# == Schema Information
#
# Table name: wishlists
#
#  id           :bigint           not null, primary key
#  uid          :string(255)
#  product_name :string(255)      default(""), not null
#  product_url  :text(65535)
#  price        :integer          default(0), not null
#  purchased_on :date
#  status       :integer          default("pending"), not null
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Wishlist < ApplicationRecord
  include Uid

  validates :product_name, presence: true
  validates :product_url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "is not a valid URL" }
  validates :price, presence: true

  belongs_to :user

  enum status: {
    pending: 0,
    done: 1
  }
end
