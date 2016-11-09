Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }

  post 'user_token' => 'user_token#create'

  namespace :v1 do
    resources :users

    namespace :forms do
      resources :tests
    end
  end
  
end
