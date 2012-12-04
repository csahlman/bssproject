class ChangeDescriptionRightInIdioms < ActiveRecord::Migration
  def change
    change_column :idioms, :description_right, :text
  end
end
