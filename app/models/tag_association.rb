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
  belongs_to :languages
  belongs_to :tags

  validates_presence_of :tag_id, :presence_id
end
