class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.datetime :read_at, default: nil
      t.text :body
      t.integer :conversation_id
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
