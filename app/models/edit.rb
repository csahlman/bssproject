# == Schema Information
#
# Table name: edits
#
#  id          :integer          not null, primary key
#  idiom_id    :integer
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Edit < ActiveRecord::Base


  validates :description, presence: true, length: { maximum: 10000 }

  belongs_to :user
  belongs_to :idiom

  default_scope order('created_at DESC')
end
