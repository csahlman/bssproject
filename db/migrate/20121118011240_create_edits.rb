class CreateEdits < ActiveRecord::Migration
  def change
    create_table :edits do |t|
      t.integer :idiom_id
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
