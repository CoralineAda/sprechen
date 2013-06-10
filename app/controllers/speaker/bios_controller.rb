class Speaker::BiosController < ApplicationController

  include ScopesAndPersistsModel

  scopes_and_persists :bio

  def index
    @bios = current_user.bios.all
  end

  def new
    @bio = current_user.bios.new
  end

  def edit
  end

  def destroy
    @bio.destroy && redirect_to(speaker_bios_path(current_user.slug))
  end

  def create
    @bio = current_user.bios.new
    handle_errors_on(:new) || redirect_to(speaker_bios_path(current_user.slug))
  end

  def update
    handle_errors_on(:edit) || redirect_to(speaker_bios_path(current_user.slug))
  end

end