Rails.application.routes.draw do

root to: 'pages#home'
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users', :sessions => "users/sessions" }





  resources :projects do
    resources :images, only: [:show, :create, :destroy, :new] do
      resources :comments,  except: [:edit,:show,:update]
    end

  end

  post '/projects/:id/invite', to: 'projects#invite', as: 'send_invitation'
  post '/projects/:id/invite/send', to: 'projects#invite_send', as: 'send_invitations'
  post '/projects/:id/:user', to: 'projects#invite_existing', as: 'send_existing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end


