class AddAnnouncementTypeToAnnouncements < ActiveRecord::Migration
  def change
    change_column :announcements, :announcement_type, :string, default: "notice"
  end
end
