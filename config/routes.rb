Rails.application.routes.draw do


  devise_for :users
  root to: 'pages#home'


  resources :projects do
    resources :images, only: [:show, :create, :destroy, :new] do
      resources :comments,  except: [:new,:edit,:index,:userspdate,:destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


