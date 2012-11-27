class ReportsController < ApplicationController

  def create
    @reportable = params[:reportable_type].classify.constantize.find(params[:reportable_id])
    @report = @reportable.reports.find_or_initialize_by_user_id(current_user.id)
    @report.user = current_user
    if @report.save
      respond_to do |f|
        f.js {}
        f.html { redirect_to root_path, flash: { notice: "Thanks for reporting." } }
        f.json { render json: @report }
      end
    else
      redirect_to root_path, flash: { error: "Please enter a message." }
    end
  end

end
