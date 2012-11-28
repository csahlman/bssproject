class AddDescriptionRightAndSummaryToEdits < ActiveRecord::Migration
  def change
    add_column :edits, :description_right, :text
    add_column :edits, :summary, :string
  end
end
