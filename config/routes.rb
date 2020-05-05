Rails.application.routes.draw do
  get 'commissions/index'
  get 'commissions/show'
  get 'commissions/new'
  get 'commissions/edit'
  #homepage
  root to: 'pages#home'

end
