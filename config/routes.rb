Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :folders, only: [ :show ] do
    resources :folders, except: [ :show, :index ], controller: 'child_folders' do
      member do
        ### 細かいですが、更新系の処理ですので get ではなく patch メソッドを使う方が REST の原則に則っています。
        get :move
      end
    end
    resources :folder_files, except: [ :index ] do
      member do
        get :download
        ### 細かいですが、更新系の処理ですので get ではなく patch メソッドを使う方が REST の原則に則っています。
        get :move
      end
      resources :sharing_files, only: [ :new, :create, :destroy ]
    end
    resources :sharing_folders, only: [ :new, :create, :destroy ]
  end

  get 'shared_files', to: 'folders#shared_files'

end
