Rails.application.routes.draw do

root to: 'pages#home'
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users' }



  resources :projects

  resources :images, only: [:show, :create, :delete], param: :project_id do
  resources :comments, param: :user_id, except: [:new,:edit,:index,:userspdate,:destroy]

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


