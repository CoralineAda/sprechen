class UsersController < ApplicationController

  def show
    redirect_to dashboard_path(current_user.slug)
  end

end