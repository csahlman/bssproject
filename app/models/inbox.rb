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


end
