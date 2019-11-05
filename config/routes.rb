Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'recipes#index'
  resources :recipes
  resources :menus, only: [:index, :new, :create]
  get '/menus/edit', to: 'menus#edit'
  get '/menus/select/:id', to: 'menus#select', as: 'select'
  post '/menus/update', to: 'menus#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
