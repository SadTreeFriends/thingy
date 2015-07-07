Rails.application.routes.draw do
  root 'static_pages#home'
  
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  
  # Automatically creates
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'
end
