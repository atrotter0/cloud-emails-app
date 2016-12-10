Rails.application.routes.draw do
  root 'home#index'
  get 'home/run_emails_export'
  post 'home/run_emails_export'
  get 'home/run_overrides_export'
  post 'home/run_overrides_export'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end