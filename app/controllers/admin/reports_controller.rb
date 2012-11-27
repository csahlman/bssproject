class Admin::ReportsController < Admin::BaseController

  def show
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
