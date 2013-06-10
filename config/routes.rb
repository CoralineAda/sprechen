Sprechen::Application.routes.draw do

  get '/auth/:provider/callback' => "sessions#create"

  match '/sign_out' => "sessions#destroy", :as => 'sign_out'

  namespace :speaker, :path => 'speaker/:user/' do
    resource :dashboard
    resources :bios
    resources :talks
  end

  root :to => 'home#index'

end
