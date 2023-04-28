class CreateFixedExpenseCategories < ActiveRecord::Migration[7.0]
  def up
    create_table :fixed_expense_categories do |t|
      t.string :uid, null: false, default: ""
      t.string :name, null: false, default: ""

      t.references :user, null: false, foreign_key: true

      t.index [:name, :user_id], unique: true
      t.index :uid, unique: true

      t.timestamps
    end
  end

  def down
    drop_table :fixed_expense_categories
  end
end
