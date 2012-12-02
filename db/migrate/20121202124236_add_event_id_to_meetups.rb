class AddEventIdToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :event_id, :integer
  end
end
