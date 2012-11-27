# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  message    :text
#  user_id    :integer
#  idiom_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :message, presence: true

  belongs_to :user
  belongs_to :idiom

  has_many :votes, as: :voteable
  has_many :reports, as: :reportable

  def total_score
    votes.sum(:vote_value)
  end

  def upvoted_by_user?(user)
    votes.where(user_id: user.id).any? && 
      votes.where(user_id: user.id).first.vote_value == 1
  end

  def downvoted_by_user?(user)
    votes.where(user_id: user.id).any? && 
      votes.where(user_id: user.id).first.vote_value == -1
  end

end
