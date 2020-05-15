Rails.application.routes.draw do
  #homepage
  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get    'sign_in',  to: 'devise/sessions#new',     as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :commissions
  patch 'commissions/:id/start',  to: 'commissions#start',  as: 'commission_start'
  patch 'commissions/:id/finish', to: 'commissions#finish', as: 'commission_finish'
end
