class AddOriginalPosterToIdiom < ActiveRecord::Migration
  def change
    add_column :idioms, :user_id, :integer
  end
end
