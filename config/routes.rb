Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show]
  root "static_pages#index"
  resources :games do
  	member do
  		post :forfeit_game
  	end
  end

  resources :pieces, only: [:update]

end
