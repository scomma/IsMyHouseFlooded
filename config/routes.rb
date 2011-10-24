Ismyhouseflooded::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'fancybox/:asset' => redirect("/assets/%{asset}"), constraints:{ asset: /.+/ }

  resources :reports, only: [:new, :create]
  post 'reports/new' => 'reports#new'
  
  root to: 'zones#index'
  resources :zones, only: [:index, :show], path: ''
end
