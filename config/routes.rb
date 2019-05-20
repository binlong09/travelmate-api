Rails.application.routes.draw do
  resources :users, param: :_id
  post 'auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
