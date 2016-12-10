Rails.application.routes.draw do
  root 'home#index'
  get 'home/run_export'
  post 'home/run_export'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end