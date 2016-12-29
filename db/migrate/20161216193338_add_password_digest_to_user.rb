class AddPasswordDigestToUser < ActiveRecord::Migration[5.0]
  # rails g migration AddPasswordDigestToUser password_digest:string
  def change
    add_column :users, :password, :digest
  end
end
