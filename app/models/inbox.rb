# == Schema Information
#
# Table name: inboxes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Inbox < ActiveRecord::Base
  belongs_to :user
  has_many :initiated_conversations, class_name: "Conversation", 
    foreign_key: "initiator_id"
  has_many :received_conversations, class_name: "Conversation",
    foreign_key: "receiver_id"

  def add_conversation(conversation, sender = nil)
    if sender  
      self.initiated_conversations << conversation
      save!      
    else
      self.received_conversations << conversation
    end  
  end  

  def unread_count
    self.user.received_messages.where(read_at: nil).count
  end

end
