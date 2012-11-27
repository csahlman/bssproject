class Admin::UsersController < Admin::BaseController

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


end
