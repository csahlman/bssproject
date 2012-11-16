module SessionsHelper

  def sign_in(user)
    #session[:user]= user.id
    cookies.permanent[:remember_token]= user.remember_token
    self.current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    #@current_user ||= User.find_by_id(session[:user])
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user= (user)
    @current_user= user
  end

  def sign_out
    self.current_user = nil
    #session[:user]= nil  
    cookies.delete(:remember_token)
  end
  
  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to sign_in_path, flash: { notice: "Please sign in to access this page." }
  end

  def store_location
    session[:return_to]= request.fullpath #return to can be any key
  #session is a cookie that persists for 1 browser session
  end

  def redirect_back_or(default, flash= nil)
    if flash
      redirect_to((session[:return_to] || default), flash)
    else
      redirect_to(session[:return_to])
    end
    clear_return_to
  end

  def clear_return_to
    session[:return_to]= nil
  end
end