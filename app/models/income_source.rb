# == Schema Information
#
# Table name: income_sources
#
#  id         :bigint           not null, primary key
#  uid        :string(255)      default(""), not null
#  source     :string(255)      default(""), not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class IncomeSource < ApplicationRecord
  include Uid

  has_many :incomes, dependent: :nullify

  belongs_to :user
end
