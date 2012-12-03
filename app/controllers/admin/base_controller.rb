class Admin::BaseController < ApplicationController
  before_filter :require_admin

  private

    def require_admin
      redirect_to root_path, flash: { error: "Error, no access" } unless 
        current_user.admin?
    end  
end