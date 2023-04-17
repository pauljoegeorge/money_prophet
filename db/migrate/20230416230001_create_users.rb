class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :uid, null: false
      t.index :uid, unique: true

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
