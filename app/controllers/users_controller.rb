class UsersController < ApplicationController
  skip_before_filter :authenticate, only: [ :new, :create, :show, :index ]
  before_filter :must_be_own_profile_or_admin, only: [ :edit, :update, :destroy ]
  respond_to :html, :js, :json

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.set_user_attributes(params[:user])
    if @user.save
      sign_in(@user)
      respond_with @user do |f|
        f.html { redirect_to @user, flash: { notice: 
            "#{@user.name} successfully created"} }
        f.json { }
      end  
    else
      respond_with @user do |f|
        f.html { render action: 'new' }
      end  
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @edits_count = Edit.where(user_id: @user).count
  end

  def edit
  end

  def update
    @user.set_user_attributes(params[:user])
    if @user.save
      respond_with @user do |f|
        f.html { redirect_to @user, flash: { notice: "#{@user.name} successfully updated"} }
        f.json { }
      end  
    else
      respond_with @user do |f|
        f.html { render action: 'edit' }
      end  
    end
  end

  private
    def must_be_own_profile_or_admin
      @user = User.find(params[:id])
      redirect_to root_path, flash: { error: "You don't have access to that" } unless
        @user == current_user || current_user.admin?
    end
end
