Rails.application.routes.draw do
  devise_for :users
  #devise_for :users do
  #get '/users/sign_out' => 'devise/sessions#destroy'
  
#end
devise_scope :user do  
   get '/users/sign_out' => 'devise/sessions#destroy'     
end
  #get 'persons/profile'
  root "articles#index"
  #root "users#index"
  get 'persons/profile', as: 'user_root'

  resources :articles do
    resources :comments
  end
end

