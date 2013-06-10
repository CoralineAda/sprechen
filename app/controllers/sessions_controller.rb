class SessionsController < ApplicationController

  def create
    user.persisted? ? handle_success : handle_failure
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to root_url
  end

  private

  def handle_success
    flash[:notice] = "Signed in! Welcome."
    session[:user_id] = user.id
    redirect_to speaker_dashboard_url(current_user.slug)
  end

  def handle_failure
    flash[:notice] = "Eep! Could not sign you in."
    redirect_to root_url
  end

  def dump_oauth_info
    raise request.env['omniauth.auth'].to_yaml
  end

  def user
    @user ||= User.for_omniauth(request.env["omniauth.auth"])
  end

end
