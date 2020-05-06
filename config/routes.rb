Rails.application.routes.draw do
  #homepage
  root to: 'pages#home'

  resources :commissions
end
