Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL avairoot to 'logs#index'
  root to: "logs#index"  
  resources :logs do
    resources :comments, only: [:create] 
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
