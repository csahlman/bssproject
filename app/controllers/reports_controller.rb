class ReportsController < ApplicationController
  before_filter :get_reportable

  def create
    @report = @reportable.reports.new
    if params[:report]
      @report.message = params[:report][:message]
    end
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

  private

    def get_reportable
      @reportable = params[:reportable].classify.constantize.find(reportable_id)
    end

    def reportable_id
      params[(params[:reportable].singularize + "_id").to_sym]
    end
end
