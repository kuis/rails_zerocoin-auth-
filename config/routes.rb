Rails.application.routes.draw do
  apipie
  root to: 'visitors#index'
  devise_for :users
  resources :users

  scope module: "api", defaults: { format: :json } do
    scope "api" do
      namespace :v1 do
        resource :auth,  only: [:create, :destroy], controller: "auth"

        resource :users do
          post "reset_password" => "users#reset_password"
         
          post "verify_password_token" => "users#verify_password_token"
         
          get "verify_email" => "users#verify_email_token"
         
          post ":id/resend_verification_email" => "users#resend_verification_email"
         
        end
      end
    end
  end
end


