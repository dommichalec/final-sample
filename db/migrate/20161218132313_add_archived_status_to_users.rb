class AddArchivedStatusToUsers < ActiveRecord::Migration[5.0]
  # rails g migration AddArchivedStatusToUsers archived:boolean
  def change
    add_column :users, :archived, :boolean, :default => false
  end
end
