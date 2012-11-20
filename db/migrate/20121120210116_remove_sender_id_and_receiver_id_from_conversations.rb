class RemoveSenderIdAndReceiverIdFromConversations < ActiveRecord::Migration
  def up
    remove_column :conversations, :sender_id, :integer
    remove_column :conversations, :receiver_id, :integer
  end

  def down
    add_column :conversations, :sender_id, :integer
    add_column :conversations, :receiver_id, :integer    
  end
end
