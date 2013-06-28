class Conferences::SearchController < ApplicationController

  def new
    @search = Conferences::Search.new
  end

  def create
    @search = Conferences::Search.new(params[:conferences_search])
    @results = @search.results
    render :show
  end

  def show
  end

end