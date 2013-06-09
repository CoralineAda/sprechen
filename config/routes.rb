Sprechen::Application.routes.draw do

  get '/auth/:provider/callback' => "sessions#create"
  match '/sign_out' => "sessions#destroy", :as => 'sign_out'

  resources :dashboards

  root :to => 'home#index'

end
