class Speaker::DashboardsController < ApplicationController

  before_filter :ensure_current_user

  def show
    redirect_to root_path unless session[:user_id]
    @dashboard = Speaker::Dashboard.new(:user_id => current_user.id)
  end

end