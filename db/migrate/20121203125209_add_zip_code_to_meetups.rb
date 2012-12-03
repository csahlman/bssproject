class AddZipCodeToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :zip_code, :string
  end
end
