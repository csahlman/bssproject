class Admin::ReportsController < ApplicationController
  before_filter :must_be_admin, only: [ :show, :update, :destroy, :index ]


  def show
  end

  def index
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
