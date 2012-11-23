class Admin::UsersController < ApplicationController
  before_filter :redirect_unless_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def soft_delete
    @user = User.find(params[:id])
    @user.soft_delete
    respond_to do |f|
      f.js
    end
  end

  def toggle_ban
    @user = User.find(params[:id])
    @user.toggle!(:banned)
  end

  private

    def redirect_unless_admin
      redirect_to root_path, flash: { error: "Error, you don't have access" } unless
        current_user.admin?
    end
end
