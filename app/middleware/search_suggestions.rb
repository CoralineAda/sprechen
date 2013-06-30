class SearchSuggestions

  def initialize(app)
    @app = app
  end

  def call(env)
    if env["PATH_INFO"] == "/topics"
      puts
      [200, {"Content-Type" => "application/json"}, [terms(env).to_json]]
    else
      @app.call(env)
    end
  end

  def terms(env)
    Conference::Topic.terms_for(Rack::Request.new(env).params['term'])
  end

end
