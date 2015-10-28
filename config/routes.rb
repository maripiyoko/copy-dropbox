Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :folders, only: [ :show ] do
    resources :folders, except: [ :show, :index ], controller: 'child_folders'
    resources :uploaded_files, except: [ :show, :index ]
  end

end
