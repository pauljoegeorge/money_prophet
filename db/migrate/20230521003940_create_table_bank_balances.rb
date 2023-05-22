class CreateTableBankBalances < ActiveRecord::Migration[7.0]
  def up
    create_table :bank_balances do |t|
      t.string :uid
      t.date :date, null: false
      t.integer :amount, null: false, default: 0

      t.references :user, null: false, foreign_key: true

      t.index [:date, :user_id], unique: true
      t.index :uid, unique: true
      t.timestamps
    end
  end

  def down
    drop_table :bank_balances
  end
end
