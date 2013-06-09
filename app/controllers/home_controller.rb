class HomeController < ApplicationController

  def index
    redirect_to dashboard_path(current_user.slug) if current_user
  end

end