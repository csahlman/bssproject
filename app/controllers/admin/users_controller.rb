class Admin::UsersController < ApplicationController
  before_filter :redirect_unless_admin

  def index
    @users = User.all
  end

  def show
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
    respond_to do |f|
      f.js
    end
  end

  private

    def redirect_unless_admin
      redirect_to root_path, flash: { error: "Error, you don't have access" } unless
        current_user.admin?
    end
end
