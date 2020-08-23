Rails.application.routes.draw do

  root "users#index"
  post 'login', to: 'users#login'
  get 'random', to: 'quotes#random'
  get 'flow', to: 'quotes#flow'
  resources :users do
    get 'booksdetail', to: 'users#booksdetail'
    resources :books do
      resources :quotes
    end
  end
end
