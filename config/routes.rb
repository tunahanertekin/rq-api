Rails.application.routes.draw do

  root "users#index"
  post 'login', to: 'users#login'
  get 'random', to: 'quotes#random'
  get 'flow', to: 'quotes#flow'
  resources :users do
    get 'booksdetail', to: 'users#booksdetail'
    resources :books do
      get 'quotesdetail', to: 'books#quotesdetail'
      resources :quotes do
        get 'detail', to: 'quotes#detail' 
      end
    end
  end
end
