class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :password_digest, :string
    add_column :users, :uqid, :string, null: false, unique: true
  end

  def down
    remove_column :users, :password_digest
    remove_column :users, :uqid
  end
end
