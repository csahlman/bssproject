class CreateTagAssociations < ActiveRecord::Migration
  def change
    create_table :tag_associations do |t|
      t.integer :tag_id
      t.integer :idiom_id

      t.timestamps
    end
  end
end
