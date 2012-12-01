class UsersController < ApplicationController
  skip_before_filter :authenticate, only: [ :new, :create, :show, :index ]
  before_filter :must_be_own_profile_or_admin, only: [ :edit, :update, :destroy ]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.set_user_attributes(params[:user])
    if @user.save
      sign_in(@user)
      respond_to do |f|
        f.html { redirect_to @user, flash: { notice: 
            "#{@user.name} successfully created"} }
        f.json { render json: @user }
      end  
    else
      respond_to do |f|
        f.html { render action: 'new' }
      end  
    end
  end

  def index
    @users = User.all
    respond_to do |f|
      f.html
      f.json { render json: @users }
    end    
  end

  def show
    @user = User.find(params[:id])
    @edits_count = Edit.where(user_id: @user).count
    respond_to do |f|
      f.html
      f.json { render json: @user }
    end
  end

  def edit
  end

  def update
    @user.set_user_attributes(params[:user])
    if @user.save
      respond_to do |f|
        f.html { redirect_to @user, flash: { notice: "#{@user.name} successfully updated"} }
        f.json { respond_with @user }
      end
    else
      respond_to do |f|
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
