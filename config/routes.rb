Rails.application.routes.draw do
  resources :jobs
  get "/remote", to: "jobs#remote"
  resources :users, only: [:create, :delete, :update, :show]
  resources :saves, only: [:create, :delete]
end
