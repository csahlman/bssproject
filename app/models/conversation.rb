# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  initiator_id :integer
#  receiver_id  :integer
#

class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :initiator, class_name: "Inbox", foreign_key: "initiator_id"
  belongs_to :receiver, class_name: "Inbox", foreign_key: "receiver_id"

  default_scope order("updated_at DESC")

  def self.find_or_new(sender_id, receiver_id)
    m1 = Message.where('sender_id = ? AND receiver_id = ?', sender_id, receiver_id)
    m2= Message.where('sender_id = ? AND receiver_id = ?', receiver_id, sender_id)
    message = m1+m2
    if message.first
      message.first.conversation
    else
      Conversation.new
    end
  end

  def mark_as_read(reader)
    messages.each do |message|
      if message.read_at.nil? && message.receiver == reader
        message.update_attribute(:read_at, Time.now)
      end
    end
  end

  def has_unread_messages?(current_user)
    self.messages.each do |message|
      if message.read_at.nil? && message.receiver_id == current_user
        return true
      end
    end
    return false
  end

  def other_user(current_user)
    m1 = messages.where(receiver_id: current_user.id).first
    m2 = messages.where(sender_id: current_user.id).first
    if m1
      m1.sender
    else
      m2.receiver
    end
  end
end
