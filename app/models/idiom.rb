# == Schema Information
#
# Table name: idioms
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  description_right :string(255)
#  summary           :string(255)
#

class Idiom < ActiveRecord::Base

  validates :title, presence: true, length: { maximum: 1000 },
    uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 30000 }
  validates :description_right, presence: true, length: { maximum: 10000 }
  validates :summary, presence: true, length: { within: 10..140 }

  belongs_to :user
  
  has_many :comments, dependent: :destroy 
  has_many :tags, through: :tag_associations
  has_many :tag_associations, dependent: :destroy
  has_many :edits, dependent: :destroy

  has_many :reports, as: :reportable, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy

  has_many :meetups, dependent: :destroy

  def to_param
    "#{id} #{title}".parameterize
  end

  def set_idiom_attributes(idiom_hash)
    self.description = idiom_hash[:description]
    self.description_right = idiom_hash[:description_right]
    self.summary = idiom_hash[:summary]
    self.title = idiom_hash[:title]
  end
 

  def create_new_edit(edit_user, updated_time = nil)
    edit = edits.new
    updated_time ? edit.edited_at = updated_time : edit.edited_at = self.updated_at
    edit.user = edit_user
    edit.description = self.description
    edit.description_right = self.description_right
    edit.summary = self.summary
    save!
    edit
  end

  def upvoted_by_user?(user)
    votes.where(user_id: user.id).any? && 
      votes.where(user_id: user.id).first.vote_value == 1
  end

  def downvoted_by_user?(user)
    votes.where(user_id: user.id).any? &&
      votes.where(user_id: user.id).first.vote_value == -1
  end

  def contributors_with_counts
    my_array = []
    uniq_edits = self.edits.uniq_by { |edit| edit.user_id }
    uniq_edits.each do |edit| 
      my_array << { user: edit.user, count: edit.edited_by }
    end
    my_array
    # returns array of hashes of users and respective counts
  end

  def total_score
    votes.sum(:vote_value)
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).idioms
  end

  def self.deliver_edit_email(user, idiom, edit)
    if user.receive_emails?
      EditMailer.delay.idiom_edit_mailer(user.id, idiom.id, edit.id)
    end
  end

  # def self.tag_counts
  #   Tag.select("tags.*, count(tag_associations.tag_id) as count").
  #       joins(:tag_associations).group("tag_associations.tag_id")
  # end

  def self.tag_counts
    Tag.select("tags.id, tags.name, count(tag_associations.tag_id) as count").
      joins(:tag_associations).group("tag_associations.tag_id, tags.id, tags.name")
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip.downcase.split(' ').join('-')).first_or_create!
      #go through the tags, strip out the commas and whitespace and find it,
      # or create it, and map it on the self.tags array
      # gets saved in the controller
    end  
  end

  def random_tag
    self.tags.sample
  end
end
