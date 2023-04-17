class CreateUnexpectedExpenses < ActiveRecord::Migration[7.0]
  def up
    create_table :unexpected_expenses do |t|
      t.string :uid, null: false, default: ""
      t.date :apply_in, null: false
      t.integer :amount, default: 0

      t.index :uid, unique: true
      t.timestamps

      t.references :unexpected_expense_category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end

  def down
    drop_table :unexpected_expenses
  end
end
