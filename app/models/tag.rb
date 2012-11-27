# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  has_many :idioms, through: :tag_associations
  has_many :tag_associations, dependent: :destroy

  has_many :votes, as: :voteable
  has_many :reports, as: :reportable


  validates :name, presence: true, length: { maximum: 50 },
    uniqueness: { case_sensitive: false }

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
