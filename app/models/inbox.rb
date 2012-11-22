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

  # def self.unread_count(conversations)
  #   count = 0
  #   conversations.each do |convo|
  #     if convo.has_unread_messages?
  #       count+=1
  #     end
  #   end
  #   count
  # end

  def unread_count
    count = 0
    initiated_conversations.each do |convo|
      if convo.has_unread_messages?
        count+=1
      end
    end
    received_conversations.each do |convo|
      if convo.has_unread_messages?
        count+=1
      end
    end
    count
  end

end
