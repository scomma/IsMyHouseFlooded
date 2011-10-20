Ismyhouseflooded::Application.routes.draw do
  resources :zones
  resources :reports

  root to: 'zones#index'
end
