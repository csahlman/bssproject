class AddAnnouncementTypeToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :announcement_type, :string, default: "notice"
  end
end
