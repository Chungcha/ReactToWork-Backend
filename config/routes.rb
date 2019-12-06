Rails.application.routes.draw do
  resources :jobs
  get "/stackoverflowjobs", to: "jobs#stackoverflowjobs"
  resources :users, only: [:create, :delete, :update]
  get "/profile", to: "users#show"
  post '/login', to: 'auth#create'
  post "/validateUsername", to: "users#validateUsername"
  resources :saves
end
