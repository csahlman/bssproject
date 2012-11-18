class AddEditedAtToEdits < ActiveRecord::Migration
  def change
    add_column :edits, :edited_at, :datetime
  end
end
