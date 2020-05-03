Rails.application.routes.draw do

  root "users#index"

  resources :users do
    resources :books
  end
end
