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
require "rails_helper"

RSpec.describe User, type: :model do
  let(:normal_user) { create(:user, :with_fixed_expenses) }

  it "is valid with a name" do
    user = User.new(
      name: "joe"
    )
    expect(user).to be_valid
  end

  it "is not valid without a name" do
    user = User.new
    expect(user).not_to be_valid
  end

  it "has fixed expenses" do
    expect(normal_user.fixed_expenses.size).to eq 3
  end

  it "has fixed expense categories" do
    expect(normal_user.fixed_expense_categories.size).to eq 3
  end
end
