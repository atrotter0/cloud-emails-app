Rails.application.routes.draw do
  root 'home#index'
  post 'home/emails_export'
  get 'home/emails-export'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
