Rails.application.routes.draw do

  resources :items
  # users#show > items#index of that user
  resources :users, only: [:show] do
    resources :items, only: [:index, :show, :create]  
  end
end