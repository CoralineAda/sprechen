class HomeController < ApplicationController

  def index
    redirect_to speaker_dashboard_path(current_user.slug) if current_user
  end

end