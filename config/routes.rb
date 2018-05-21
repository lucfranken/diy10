
Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :receipts
    resources :suppliers
  end

  devise_for :users
  
  get 'welcome/index'
 
  root 'welcome#index'

  resources :receipts
end