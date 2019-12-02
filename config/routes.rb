Rails.application.routes.draw do
  resources :jobs
  get "/remote", to: "jobs#remote"
  resources :users, only: [:create, :delete, :update, :show]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  resources :saves, only: [:create, :delete]
end
