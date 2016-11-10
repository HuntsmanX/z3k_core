Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: 'users/registrations' }, defaults: { format: :json }

  post 'user_token' => 'user_token#create'

  namespace :v1 do
    resources :users

    namespace :forms do
      resource  :dashboard

      resources :tests

      namespace :test do
        resources :sections
        resources :questions
      end

      resources :responses do
        get 'start', action: 'start'
      end

      namespace :response do
        resources :sections
        resources :questions
      end

    end
  end
  
end
