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

require 'spec_helper'

describe Message do
  pending "add some examples to (or delete) #{__FILE__}"
end
