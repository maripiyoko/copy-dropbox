Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :folders, only: [ :show ] do
    resources :folders, except: [ :show, :index ], controller: 'child_folders' do
      member do
        get :move
      end
    end
    resources :folder_files, except: [ :index ] do
      member do
        get :download
      end
    end
  end

end
