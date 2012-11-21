class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def new
  end

  def create
    # raise env['omniauth.auth'].to_yaml
    if env['omniauth.auth']
      begin
        user = User.from_omniauth(env['omniauth.auth'])
      rescue  
        redirect_to root_path, flash: { error: "Email already exists, please login normally." }
      end
      sign_in(user)
      redirect_back_or root_url, flash: { notice: "Welcome #{user.name}." }
    elsif User.find_by_email(params[:email])
      user= User.find_by_email(params[:email])
      if user.password_digest && user.authenticate(params[:password])
        sign_in(user)
        redirect_back_or root_url, flash: { notice: "Welcome #{user.name} "}
      else  
        flash.now[:error] = "Login using facebook"
        render 'new'
      end
    end
    # user = User.find_by_email(params[:email])
    # if user and user.authenticate(params[:password])
    #   sign_in(user)
    #   redirect_back_or(root_url, flash: { notice: "Welcome back #{user.name}" } ) 
    # else
    #   flash.now[:error]= "Invalid email/password combo"
    #   #need flash.now on a render request because it won't count the render as a request
    #   # instead it will persist through 2 pages, redirect you don't need it
    #   render 'new' 
    # end 
  end

  def destroy
    sign_out
    redirect_to root_url, flash: { notice: "Logged out" }
  end
end