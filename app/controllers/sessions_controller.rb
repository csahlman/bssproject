class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      sign_in(user)
      redirect_back_or(root_url, flash: { notice: "Welcome back #{user.name}" } ) 
    else
      flash.now[:error]= "Invalid email/password combo"
      #need flash.now on a render request because it won't count the render as a request
      # instead it will persist through 2 pages, redirect you don't need it
      render 'new' 
    end 
  end

  def destroy
    sign_out
    redirect_to root_url, flash: { notice: "Logged out" }
  end
end