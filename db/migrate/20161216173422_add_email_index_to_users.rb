class AddEmailIndexToUsers < ActiveRecord::Migration[5.0]
  # rails g migration AddIndexToUsers
  def change
    add_index :users, :email, unique: true
  end
end
