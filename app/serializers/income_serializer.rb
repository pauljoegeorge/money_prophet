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
class IncomeSerializer < ActiveModel::Serializer
  attributes :amount, :source
end
