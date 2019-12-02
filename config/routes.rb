Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL avairoot to 'logs#index'

  root to: "logs#index"  
  resources :logs do
    resources :comments, only: [:create] 
    namespace :api do
      resources :comments, only: :index, defaults: { format: 'json' }
    end
  end
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

end
