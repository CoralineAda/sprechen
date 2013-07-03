class ConferencesController < ApplicationController

  include ScopesAndPersistsModel

  before_filter :ensure_current_user
  scopes_and_persists :conference, :class_name => 'Conference::Conference'

  def new
    @conference = current_user.conferences.new
  end

  def edit
  end

  def show
  end

  def destroy
    @conference.destroy && redirect_to(speaker_calendar_path(current_user.slug))
  end

  def create
    @conference = current_user.conferences.new
    handle_errors_on(:new) || redirect_to(speaker_calendar_path(current_user.slug))
  end

  def update
    handle_errors_on(:edit) || redirect_to(speaker_calendar_path(current_user.slug))
  end

end