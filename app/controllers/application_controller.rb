class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  ActionController::Base
  protect_from_forgery with: :exception
  
  

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def user_status
    @user_status ||= session[:status] if session[:status]
  end
  helper_method :current_user
end
