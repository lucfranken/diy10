
Rails.application.routes.draw do
  namespace :admin do
    resources :dashboards
    resources :categories
    resources :receipts
    get "/receipts/index/:scope", to: "receipts#scoped", as: "scope"
    resources :suppliers
  end

  devise_for :users
  
  get "/welcome/chart_per_category", to: "welcome#chart_per_category"

  get 'welcome/index'
 
  root 'welcome#index'

  resources :receipts
end