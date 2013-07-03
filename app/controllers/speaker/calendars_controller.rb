class Speaker::CalendarsController < ApplicationController

  before_filter :ensure_current_user

  def show
    redirect_to root_path unless session[:user_id]
    @calendar = Speaker::Calendar.new(current_user)
  end

end