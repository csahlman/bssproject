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
  validates :title, presence: true, length: { maximum: 1000 },
    uniqueness: { case_sensitive: false }
  validates :description, presence: true   
end
