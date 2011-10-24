Ismyhouseflooded::Application.routes.draw do
  root to: 'zones#index'
  get 'index' => 'zones#index', as: 'zones'
  get ':id'   => 'zones#show',  as: 'zone', constraints:{ id: /[0-9]{5}/ }

  resources :reports, only: [:new, :create]
  post 'reports/new' => 'reports#new'

  resources :pages, only: :show

  assets_host = redirect "#{Rails.application.config.action_controller.asset_host}/assets/%{asset}"
  get 'fancybox/:asset' => assets_host, constraints:{ asset: /.+/ }
  get '*legacy_browser_support/fancybox/:asset' => assets_host, constraints:{ asset: /.+/ }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
end
