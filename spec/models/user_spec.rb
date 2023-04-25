require 'rails_helper'

RSpec.describe User, type: :model do
  let(:normal_user) { create(:user, :with_fixed_expenses) }

  it "is valid with a name" do
    user = User.new(
      name: "joe",
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