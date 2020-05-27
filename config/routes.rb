Rails.application.routes.draw do
  # Homepage
  root to: 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    get    'sign_in',  to: 'devise/sessions#new',     as: :new_user_session
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :commissions do
    member do
      post   'upload',     to: 'commissions#upload_file', as: 'upload_file'
      delete 'delete/:id', to: 'commissions#delete_file', as: 'delete_file'
    end
  end

  patch 'commissions/:id/start',  to: 'commissions#start',  as: 'commission_start'
  patch 'commissions/:id/finish', to: 'commissions#finish', as: 'commission_finish'

  resources :folders do
    resources :commissions, only: :show
  end
end
