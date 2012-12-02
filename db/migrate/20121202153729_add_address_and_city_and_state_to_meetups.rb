class AddAddressAndCityAndStateToMeetups < ActiveRecord::Migration
  def change
    add_column :meetups, :address, :string
    add_column :meetups, :city, :string
    add_column :meetups, :state, :string
  end
end
