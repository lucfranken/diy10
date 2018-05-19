
Rails.application.routes.draw do
  namespace :admin do
    resources :categories
    resources :receipts
    resources :suppliers
  end

  devise_for :users
  get 'welcome/index'

  resources :receipts
 
  root 'welcome#index'
end