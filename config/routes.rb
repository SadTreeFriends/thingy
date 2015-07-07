Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  
  # Automatically creates
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'
end
