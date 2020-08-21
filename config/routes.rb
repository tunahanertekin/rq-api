Rails.application.routes.draw do

  root "users#index"
  post 'login', to: 'users#login'
  get 'random', to: 'users#random'
  resources :users do
    resources :books do
      resources :quotes
    end
  end
end
