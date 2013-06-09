class SessionsController < ApplicationController

  def create
    handle_success if user.persisted?
    handle_failure
  end

  private

  def handle_success
    flash[:notice] = "Signed in! Welcome."
    session[:user] = @user
    redirect_to root_url
  end

  def handle_failure
    flash[:notice] = "Eep! Could not sign you in."
    redirect_to root_url
  end

  def dump_oauth_info
    raise request.env['omniauth.auth'].to_yaml
  end

  def user
    session[:user] ||= User.for_omniauth(request.env["omniauth.auth"])
  end

end
