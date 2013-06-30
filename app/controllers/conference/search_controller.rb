class Conference::SearchController < ApplicationController

  autocomplete :topic, :name

  def new
  end

  def create
    @search = Conference::Search.create(params[:conference_search])
    @results = @search.results
    render :show
  end

  def show
  end

end