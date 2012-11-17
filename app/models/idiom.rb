# == Schema Information
#
# Table name: idioms
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Idiom < ActiveRecord::Base
  attr_accessible :tag_list

  validates :title, presence: true, length: { maximum: 1000 },
    uniqueness: { case_sensitive: false }
  validates :description, presence: true  
  
  has_many :comments, dependent: :destroy 
  has_many :tags, through: :tag_associations
  has_many :tag_associations, dependent: :destroy

  def self.tagged_with(name)
    Tag.find_by_name!(name).idioms
  end

  def self.tag_counts
    Tag.select("tags.*, count(tag_associations.tag_id) as count").
        joins(:tag_associations).group("tag_associations.tag_id")
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
      #go through the tags, strip out the commas and whitespace and find it,
      # or create it, and map it on the self.tags array
      # gets saved in the controller
    end  
  end
end
