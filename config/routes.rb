Falcon::Application.routes.draw do
  devise_for :account, :controllers => { :registrations => "account/registrations", :omniauth_callbacks => "account/omniauth_callbacks" }
  resources :blogposts
  resources :showcases

  resources :accounts do
    member do
      get :following, :followers
    end
  end

  namespace :account do
    resource :profile, :only => [:show, :edit, :update]
    resource :language_settings, :only => [:edit, :update]

    resources :pictures do
      resources :comments
      resources :likes, :only => [:create]

      collection do
        post :upload
        post :apply_filter
      end
    end

    scope ":profile_id", :as => :view do
      resources :pictures, :only => [:index, :show]

      get "" => "profiles#show"
    end
  end

  devise_for :affiliate, :controllers => { :registrations => "affiliate/registrations" }

  namespace :affiliate do
    resource :business_profiles, :only => [:edit, :update]
    resource :language_settings, :only => [:edit, :update]
  end

  devise_for :admin

  namespace :admin do
    resource :profile, :only => [:edit, :update]

    resources :accounts
    resources :admins
    resources :affiliates

    root :to => "accounts#index"
  end

  get "home/index"

  root :to => "home#index"


end
