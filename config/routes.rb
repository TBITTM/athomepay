Rails.application.routes.draw do
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'signup', to: 'users#new'
    resources :users, only: [:index, :show, :new, :create]
    resources :tasks, only: [:index, :show, :new, :create, :destroy, :update, :edit]
    resources :account_activities, only: [:index, :show, :new, :create, :destroy, :update, :edit] do
        collection do
      get :history
    end
end
end