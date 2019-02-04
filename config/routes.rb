Rails.application.routes.draw do
  root 'welcome#index'
  resources :books do
    resources :reviews
  end
  resources :authors
  resources :users, only: [:show]

end
