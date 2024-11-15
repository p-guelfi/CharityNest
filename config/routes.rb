Rails.application.routes.draw do
  get 'charity_projects/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :categories, only: %i[new create] do
    resources :charities, only: :index # Nest charities under categories for filtered index
  end

  resources :charities do
    resources :charity_projects, only: %i[new create] # Nest donations under charity projects
  end

  resources :charity_projects, except: %i[new create] do

    resources :donations, only: [:new, :create]

    # Discussions nested under Charity Projects to enable discussions for all projects
    resources :discussions do
    # Comments nested under discussions
      resources :comments, only: [:create, :destroy]
    end

    resources :reports, only: %i[new create index]
  end

  resources :reports, only: %i[show edit update index]

  resources :donations, only: %i[index show edit update] do
    member do
      delete 'unsubscribe'
    end
    resources :payments, only: :new
    resources :discussions do
      resources :comments, only: [:create, :destroy]
    end

  end

  mount StripeEvent::Engine, at: '/webhooks/stripe'

  post '/chat', to: 'chat#create'
end
