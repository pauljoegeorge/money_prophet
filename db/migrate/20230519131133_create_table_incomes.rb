class CreateTableIncomes < ActiveRecord::Migration[7.0]
  def up
    create_table :income_sources do |t|
      t.string :uid, null: false, default: ""
      t.string :source, null: false, default: ""

      t.references :user, null: false, foreign_key: true

      t.index [:source, :user_id], unique: true
      t.index :uid, unique: true

      t.timestamps
    end

    create_table :incomes do |t|
      t.string :uid, null: false, default: ""
      t.date :apply_from, null: false
      t.integer :amount, default: 0

      t.index :uid, unique: true
      t.timestamps

      t.references :income_source, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end

  def down
    drop_table :incomes
    drop_table :income_sources
  end
end
