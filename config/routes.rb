Rails.application.routes.draw do
  #homepage
  root to: 'pages#home'

  devise_for :users

  resources :commissions
  patch 'commissions/:id/start',  to: 'commissions#start',  as: 'commission_start'
  patch 'commissions/:id/finish', to: 'commissions#finish', as: 'commission_finish'
end
