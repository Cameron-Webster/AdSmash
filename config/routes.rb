Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  resources :projects


  resources :images, only: [:show, :create, :delete], param: :project_id do
    resources :comments, param: :user_id, except: [:new,:edit,:index,:userspdate,:destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


