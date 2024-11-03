Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :categories, only: [:new, :create] do
    resources :charities, only: :index # Nest charities under categories for filtered index
  end

  resources :charities do
    resources :charity_projects, only: [:new, :create] # Nest donations under charity projects
  end

  resources :charity_projects, except: %i[new create] do
    resources :donations, only: [:new, :create]
  end

  resources :donations, only: [:index, :show, :edit, :update]
end
