class Speaker::TalksController < ApplicationController

  include ScopesAndPersistsModel

  scopes_and_persists :talk, :class_name => "Talk::Talk"

  before_filter :ensure_current_user
  before_filter :scope_abstract, :only => [:new, :edit, :create, :update]

  def index
    @talks = current_user.talks.desc(:created_at)
  end

  def new
    @talk = current_user.talks.new
  end

  def edit
  end

  def show
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
    @abstract.update_attributes(params[:talk_abstract])
    redirect_to(speaker_talks_path(current_user.slug))
  end

  private

  def scope_abstract
    @abstract = @talk.abstracts.first
    @abstract ||= params[:talk_abstract].present? && params[:talk_abstract][:id].present? && @talk.abstracts.where(params[:talk_abstract][:id]).first
    @abstract ||= @talk.abstracts.build(params[:talk_abstract])
  end

end