# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy

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
end
