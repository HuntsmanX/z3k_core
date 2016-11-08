Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :users

    namespace :forms do
      resources :tests
    end
  end

  post 'user_token' => 'user_token#create'
end
