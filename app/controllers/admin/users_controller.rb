class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.set_user_attributes params[:user]
    if @user.save
      redirect_to [:admin, @user], flash: { notice: "rocked it" }
    else
      render 'admin/users/new'
    end    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.set_user_attributes params[:user]
    if @user.save
      redirect_to [:admin, @user], flash: { notice: "rocked it" }
    else
      render 'admin/users/edit'
    end
  end

  def soft_delete
    @user = User.find(params[:id])
    @user.soft_delete
  end

  def toggle_ban
    @user = User.find(params[:id])
    @user.toggle!(:banned)
  end


end
