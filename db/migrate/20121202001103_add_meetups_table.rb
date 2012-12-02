class AddMeetupsTable < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
      t.string :name
      t.string :group_name
      t.string :event_url
      t.text :description 
      t.datetime :meetup_time
      t.float :latitude
      t.float :longitude
      t.integer :attending
      t.integer :idiom_id
      t.timestamps
    end
  end
end
