class AddTypeToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :announcement_type, :string
  end
end
