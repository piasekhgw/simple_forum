class ExtendUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, null: false
    change_column :users, :email, :string, null: false
    change_column :users, :name, :string, null: false
  end
end
