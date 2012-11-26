class AddDescriptionRightToIdioms < ActiveRecord::Migration
  def change
    add_column :idioms, :description_right, :string
  end
end
