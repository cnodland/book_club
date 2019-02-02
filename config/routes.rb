Rails.application.routes.draw do
  root 'welcome#index'
  resources :books
  resources :authors
end
