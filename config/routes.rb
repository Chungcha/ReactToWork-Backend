Rails.application.routes.draw do
  resources :jobs
  resources :users, only: [:create, :delete, :update, :show]
  resources :saves, only: [:create, :delete]
end
