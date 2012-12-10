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


end
