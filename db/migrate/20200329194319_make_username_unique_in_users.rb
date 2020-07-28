# MakeUsernameUniqueInUsers
class MakeUsernameUniqueInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :username, :string, null: false, default: ''
  end

  add_index :users, :username, unique: true
end
