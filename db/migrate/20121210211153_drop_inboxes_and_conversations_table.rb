class DropInboxesAndConversationsTable < ActiveRecord::Migration
  def up
    drop_table :inboxes
    drop_table :conversations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
