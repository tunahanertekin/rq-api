Rails.application.routes.draw do

  root "users#index"

  resources :users do
    resources :books do
      resources :quotes
    end
  end
end
