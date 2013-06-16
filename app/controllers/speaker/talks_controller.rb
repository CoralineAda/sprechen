class Speaker::TalksController < ApplicationController

  include ScopesAndPersistsModel

  scopes_and_persists :talk

  before_filter :scope_abstract, :only => [:new, :edit, :create, :update]

  def index
    @talks = current_user.talks.desc(:created_at)
  end

  def new
    @talk = current_user.talks.new
  end

  def edit
  end

  def destroy
    @talk.destroy && redirect_to(speaker_talks_path(current_user.slug))
  end

  def create
    @talk = current_user.talks.new
    handle_errors_on(:new)
    @abstract.save! if @abstract.summary.present?
    redirect_to(speaker_talks_path(current_user.slug))
  end

  def update
    handle_errors_on(:edit)
    @abstract.update_attributes(params[:abstract])
    redirect_to(speaker_talks_path(current_user.slug))
  end

  private

  def scope_abstract
    @abstract = params[:abstract].present? && params[:abstract][:id].present? && @talk.abstracts.where(params[:abstract][:id]).first
    @abstract = @talk.abstracts.build(params[:abstract])
  end

end