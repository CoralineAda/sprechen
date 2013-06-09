Sprechen::Application.routes.draw do

  get '/auth/:provider/callback' => "sessions#create"

  root :to => 'home#index'

end
