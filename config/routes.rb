MyGreenSpaceAPI::Application.routes.draw do
  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users,     only: [:index, :create, :show, :update, :destroy] do
        resources :spaces,  only: [:index, :create, :show, :update, :destroy]
      end
    end
  end
end
