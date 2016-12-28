class AddPasswordToUsers < ActiveRecord::Migration[5.0]
  # rails g migration AddPasswordToUsers password_digest:string
  def change
    add_column :users, :password_digest, :string
  end
end
