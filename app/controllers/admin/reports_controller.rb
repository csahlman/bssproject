class Admin::ReportsController < Admin::BaseController

  def show
    @report = Report.find(params[:id])
    respond_to do |f|
      f.js
    end
  end

  def index
    @reports = Report.unresolved
  end

  def update
  end

  def edit
  end

  def destroy
  end


end
