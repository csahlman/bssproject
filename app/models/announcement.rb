# == Schema Information
#
# Table name: announcements
#
#  id         :integer          not null, primary key
#  message    :text
#  starts_at  :datetime
#  ends_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ActiveRecord::Base

  validates :message, presence: true, length: { maximum: 300 }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  
  scope :future, -> { where("starts_at >= :now", now: Time.zone.now) }
  scope :past, -> { where("ends_at <= :now", now: Time.zone.now) }
  # 1.9 lambda syntax

  def self.current(hidden_ids = nil)
    result = where("starts_at <= :now and ends_at >= :now", now: Time.zone.now)
    result = result.where("id not in (?)", hidden_ids) if hidden_ids.present?
    result
  end

  def starts_at_text=(time)
    self.starts_at = Time.zone.parse(time) if time.present?
  end

  def starts_at_text
    starts_at.try(:strftime, "%Y-%m-%d %H:%m:%s")
    # try is to ensure it won't brick if it's nil
  end

  def ends_at_text
    ends_at.try(:strftime, "%Y-%m-%d %H:%m:%s")
  end

  def ends_at_text=(time)
    self.ends_at = Time.zone.parse(time) if time.present?
  end


end
