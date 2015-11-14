Rails.application.routes.draw do
  apipie
  root to: 'visitors#index'
  devise_for :users
  resources :users


  scope module: "api", defaults: { format: :json } do
    scope "api" do
      namespace :v1 do
        resource :auth,  only: [:create, :destroy], controller: "auth"
        
        resources :passwords

        resources :users

        resources :transactions, only: [:create]
      end
    end
  end
end


