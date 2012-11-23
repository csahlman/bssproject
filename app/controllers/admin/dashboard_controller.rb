class Admin::DashboardController < ApplicationController
  before_filter :redirect_unless_admin

  def index
  end

  private

    def redirect_unless_admin
      redirect_to root_path, flash: { error: "Error, you don't have access" } unless
        current_user.admin?
    end
end
