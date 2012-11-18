# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  vote_value    :integer          default(0)
#  voteable_id   :integer
#  voteable_type :string(255)
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
end
