module ReportsHelper

  def report_button(reportable)
    link_to "Report Abuse", report_path(reportable_type: reportable.class.to_s,
      reportable_id: reportable.id), method: :post, 
      id: "#{reportable.class.to_s.downcase}_report_#{reportable.id}", remote: true   
  end

end
