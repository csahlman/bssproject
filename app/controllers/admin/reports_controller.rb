class Admin::ReportsController < ApplicationController
  before_filter :must_be_admin

  def show
  end

  def index
    @reports = Report.where(resolved: false).all
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

    def must_be_admin
      redirect_to root_path, flash: { error: "nooope" } unless current_user.admin? 
    end

end
