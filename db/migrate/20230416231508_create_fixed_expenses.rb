class CreateFixedExpenses < ActiveRecord::Migration[7.0]
  def up
    create_table :fixed_expenses do |t|
      t.string :uid, null: false, default: ""
      t.date :apply_from, null: false
      t.integer :amount, default: 0

      t.index :uid, unique: true
      t.timestamps

      t.references :fixed_expense_category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end

  def down
    drop_table :fixed_expenses
  end
end
