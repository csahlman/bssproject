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
  has_many :reports, as: :reportable

  default_scope order('created_at DESC')

  def edited_by
    Edit.where("user_id= ? AND idiom_id=?", user.id, idiom.id).count
  end

  def new_or_find_vote(user_id)
  	self.votes.find_by_user_id(user_id) || self.votes.new
  end

  def total_score
    votes.sum(:vote_value)
  end
end
