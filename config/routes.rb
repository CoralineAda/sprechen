Sprechen::Application.routes.draw do

  get '/auth/:provider/callback' => "sessions#create"

  match '/sign_out' => "sessions#destroy", :as => 'sign_out'

  resources :users, :path => '/speakers/' do
    member do
      resource :dashboard
      resources :bios
    end
  end

  root :to => 'home#index'

end
