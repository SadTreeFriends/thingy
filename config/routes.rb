Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  
  # Automatically creates
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'
  
  get     'login'  => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit] # provide route only for edit action
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
