BusinessSkillsDay::Application.routes.draw do

  # Define the root route, which will go the index action of the Main controller.
  root :to => 'main#index'

  # Session controller.
  get '/login' => 'sessions#new', :as => :login
  post '/login' => 'sessions#create', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout

  # Account resource to access the current user's account.
  resource :account, :only => [:show, :edit, :update]

  # Chapter (and nested) resource.
  resources :chapters, :only => [:show, :edit, :update] do
    resources :advisers do get :delete, :on => :member end
    resources :students do get :delete, :on => :member end
    resources :teams do get :delete, :on => :member end
    get :results, :on => :member
  end

  # Admin namespace.
  namespace :admin do
    resources :chapters,  :except => [:show, :edit, :update] do get :delete, :on => :member end
    resources :advisers,  :except => [:create, :show, :edit, :update]
    resources :students,  :except => [:create, :show, :edit, :update]
    resources :teams,     :except => [:create, :show, :edit, :update]
    resources :events do
      get :delete, :on => :member

      resources :results, :except => [:show] do
        get :delete, :on => :member
      end
    end
    resources :accounts do get :delete, :on => :member end

    get '/results' => 'results#main', :as => 'results'
    get '/' => 'main#index'
  end

end
