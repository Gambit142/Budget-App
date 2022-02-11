Rails.application.routes.draw do
  devise_for :users

  root "splash#index"
  
  resources :categories, only: [:index, :new, :create] do
    resources :records, only: [:index, :new, :create]
  end
end
