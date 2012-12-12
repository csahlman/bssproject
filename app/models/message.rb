# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  read_at         :datetime
#  body            :text
#  conversation_id :integer
#  sender_id       :integer
#  receiver_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ActiveRecord::Base
  
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  default_scope order('created_at DESC')

  def self.conversation(current_user_id, receiver_id)
    conversation = where('sender_id = ? AND receiver_id = ?', current_user_id, receiver_id).all +
      where('receiver_id = ? AND sender_id = ?', current_user_id, receiver_id).all
    mark_as_read(current_user_id, conversation)
    conversation.sort_by(&:created_at)
  end

  def self.mark_as_read(current_user_id, conversation)
    conversation.each do |message|
      if message.read_at.nil? && message.receiver_id == current_user_id 
        message.update_attribute(:read_at, Time.zone.now)
      end
    end
  end

  def self.all_conversations(current_user)
    other_user_ids = (current_user.received_messages.map(&:sender_id) +
      current_user.sent_messages.map(&:receiver_id)).uniq
    conversations = []
    other_user_ids.each do |user_id|
      conversations << conversation(current_user.id, user_id)
    end
    conversations
  end

  def other_user(current_user)
    sender == current_user ? receiver : sender
  end

end
