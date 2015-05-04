MyGreenSpaceAPI::Application.routes.draw do
  use_doorkeeper
  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users,     only: [:index, :create, :show, :update, :destroy] do
        resources :spaces,  only: [:index, :create, :show, :update, :destroy]
      end
      resources :password_resets, only: [:create, :update]
    end
  end

  resources :password_resets, only: :edit

  get 'test-api', to: 'home#index'

  root 'home#index'
end
