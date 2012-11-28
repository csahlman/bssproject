module ReportsHelper

  def report_button(reportable)
    if reportable.reports.find_by_user_id(current_user)
      message = "Abuse Reported"
    else
      message = "Report Abuse"
    end
    link_to message, report_path(reportable_type: reportable.class.to_s,
      reportable_id: reportable.id), method: :post, 
      id: "#{reportable.class.to_s.downcase}_report_#{reportable.id}", remote: true   
  end

end
