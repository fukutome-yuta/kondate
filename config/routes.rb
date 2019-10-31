Rails.application.routes.draw do
  get 'menus/index'
  get 'menus/show'
  get 'menus/new'
  get 'menus/edit'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'recipes#index'
  resources :recipes

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
