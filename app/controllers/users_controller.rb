class UsersController < ApplicationController
  skip_before_filter :authenticate, only: [ :new, :create, :show, :index ]
  respond_to :html, :js, :json

  def new
    @user= User.new
  end

  def create
    @user= User.new
    @user.email= params[:user][:email]
    @user.name= params[:user][:name]
    @user.password= params[:user][:password]
    @user.password_confirmation= params[:user][:password_confirmation]
    @user.about_me= params[:user][:about_me]
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
    @users= User.all
  end

  def show
    @user= User.find(params[:id])
  end

  def destroy
    @user= User.find(params[:id])
    @user.destroy
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    @user= User.find(params[:id])
    @user.email= params[:user][:email]
    @user.name= params[:user][:name]
    @user.password= params[:user][:password]
    @user.password_confirmation= params[:user][:password_confirmation]
    @user.about_me= params[:user][:about_me]
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
end
