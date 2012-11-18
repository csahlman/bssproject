class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :vote_value, default: 0
      t.integer :voteable_id
      t.string :voteable_type
      t.integer :user_id

      t.timestamps
    end
    add_index :votes, [:voteable_id, :voteable_type]
  end
end
