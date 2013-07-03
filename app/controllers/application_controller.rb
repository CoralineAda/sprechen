class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def ensure_current_user
    redirect_to root_path unless current_user
  end

end
