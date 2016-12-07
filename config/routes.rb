Rails.application.routes.draw do
  #mount_devise_token_auth_for 'User', at: 'auth', controllers: { sessions: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :users
    mount_devise_token_auth_for 'User', at: 'auth', controllers: { sessions: 'sessions' }

    namespace :forms do
      get 'tests/find_test' => 'tests#find_test'

      resource  :dashboard

      resources :tests

      namespace :test do
        resources :sections do
          put :reorder, on: :collection
        end
        resources :questions do
          put :reorder, on: :collection
        end
      end

      resources :responses

      namespace :response do
        resources :sections
        resources :questions
      end

      namespace :config do
        resources :mistake_types
      end

      get 'testees/find' => 'testees#find', constraints: {format: /(js|json)/}
    end
  end

end
