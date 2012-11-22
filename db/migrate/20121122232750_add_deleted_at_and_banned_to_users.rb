class AddDeletedAtAndBannedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime, default: nil
    add_column :users, :banned, :boolean, default: false
  end
end
