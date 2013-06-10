class Speaker::DashboardsController < ApplicationController

  def show
    redirect_to root_path unless session[:user_id]
    @dashboard = Dashboard.new(:user_id => current_user.id)
  end

end