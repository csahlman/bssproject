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
#  edited_at   :datetime
#

class Edit < ActiveRecord::Base


  validates :description, presence: true, length: { maximum: 10000 }

  belongs_to :user
  belongs_to :idiom
  has_many :votes, as: :voteable

  default_scope order('created_at DESC')
end