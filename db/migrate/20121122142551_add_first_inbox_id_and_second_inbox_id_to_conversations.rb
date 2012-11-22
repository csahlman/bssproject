class AddFirstInboxIdAndSecondInboxIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :initiator_id, :integer
    add_column :conversations, :receiver_id, :integer
  end
end
