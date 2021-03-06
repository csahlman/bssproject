# == Schema Information
#
# Table name: tag_associations
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  idiom_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagAssociation < ActiveRecord::Base
  belongs_to :idiom
  belongs_to :tag

  # validates_presence_of :tag_id, :idiom_id
end
