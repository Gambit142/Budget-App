Rails.application.routes.draw do
  devise_for :users

  root "splash#index"

  get '/records/new', to: 'records#new', as: 'new_record'
  post '/records', to: 'records#create', as: 'create_record'
  
  resources :categories, only: [:index, :new, :create] do
    resources :records, only: [:index]
  end
end
