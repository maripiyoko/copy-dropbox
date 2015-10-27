Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :folders, only: [ :show ] do
    resources :child_folders, except: [ :show, :index ]
    resources :uploaded_files, except: [ :show, :index ]
  end

end
