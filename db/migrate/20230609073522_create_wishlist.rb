# frozen_string_literal: true

class CreateWishlist < ActiveRecord::Migration[7.0]
  def up
    create_table :wishlists do |t|
      t.string :uid
      t.string :product_name, null: false, default: ""
      t.text :product_url
      t.integer :price, null: false, default: 0
      t.date :purchased_on
      t.integer :status, null: false, default: 0

      t.references :user, null: false, foreign_key: true
      t.index :uid, unique: true

      t.timestamps
    end
  end

  def down
    drop_table :wishlists
  end
end
