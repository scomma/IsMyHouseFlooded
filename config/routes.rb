Ismyhouseflooded::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'fancybox/:asset' => redirect("/assets/%{asset}"), constraints:{ asset: /.+/ }

  resources :reports, only: [:new, :create]
  post 'reports/new' => 'reports#new'

  resources :pages, only: :show
  
  root to: 'zones#index'
  get 'index' => 'zones#index', as: 'zones'
  get ':id'   => 'zones#show',  as: 'zone'
end
