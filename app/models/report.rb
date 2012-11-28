# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  reportable_type :string(255)
#  reportable_id   :integer
#  user_id         :integer
#  message         :text
#  resolved        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Report < ActiveRecord::Base
  validates :message, length: { maximum: 200 }

  belongs_to :reportable, polymorphic: true
  belongs_to :user

  scope :unresolved, where(resolved: false)

  # def proper_content
  #   case reportable.class.to_s
  #   when "Comment"
  #     reportable.message
  #   else 
  #     reportable.description
  #   end
  # end

  def unresolved_for_report
    reportable.reports.where(resolved: false)
  end

  def self.resolve_each(reports)
    reports.each do |report|
      report.update_column(:resolved, true)
    end
  end

end
