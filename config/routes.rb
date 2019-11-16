Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'recipes#index'
  resources :recipes
  post '/recipes/fetch', to: 'recipes#fetch'

  resources :menus, only: [:index, :new, :create]
  get '/menus/edit', to: 'menus#edit'
  get '/menus/select/:id', to: 'menus#select', as: 'select'
  post '/menus/update', to: 'menus#update'
  get '/menus/complete', to: 'menus#complete'
  delete '/menus/destroy', to: 'menus#destroy'

  get '/shopping_lists/show', to: 'shopping_lists#show'
  get '/shopping_lists/update', to: 'shopping_lists#update'
  post '/shopping_lists/create', to: 'shopping_lists#create'
  delete '/shopping_lists/destroy', to: 'shopping_lists#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
