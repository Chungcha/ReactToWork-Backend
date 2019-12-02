Rails.application.routes.draw do
  resources :jobs
  get "/stackoverflowjobs", to: "jobs#stackoverflowjobs"
  resources :users, only: [:create, :delete, :update, :show]
  post '/login', to: 'auth#create'
  get '/profile', to: 'users#profile'
  resources :saves, only: [:create, :delete]
end
