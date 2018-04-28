Rails.application.routes.draw do
  root "application#index"
  devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register' }

  resources :questionnaire, only: [:index, :show, :create]

end
