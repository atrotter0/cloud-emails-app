Rails.application.routes.draw do
  root 'home#index'
  get 'home/emails_export'
  post 'home/emails_export'
  # => 'home#index', as: :emails_export

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
