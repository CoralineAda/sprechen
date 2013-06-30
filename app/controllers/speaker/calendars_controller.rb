class Speaker::CalendarsController < ApplicationController

  def show
    redirect_to root_path unless session[:user_id]
    @calendar = Calendar.new(:user_id => current_user.id)
  end

end