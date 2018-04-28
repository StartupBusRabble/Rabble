Rails.application.routes.draw do
  root "application#index"
  get "/:page" => "application#show"

  devise_for :users, path: 'users', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register' }
end
