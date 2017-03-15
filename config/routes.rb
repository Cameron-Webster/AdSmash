Rails.application.routes.draw do

root to: 'pages#home'
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: 'users', :sessions => "users/sessions" }

post '/projects/:project_id/images/:image_id/comments/:id', to: 'comments#likes_manager', as: "likes"


  resources :notifications

  resources :projects do
    member do
      get "/image_show/:display_image", to: 'projects#show', as: 'old_image'
    end
    resources :images, only: [:show, :create, :destroy, :new] do
      resources :comments,  except: [:edit,:show]
    end




  end

  post '/projects/:id/invite', to: 'projects#invite', as: 'send_invitation'
  post '/projects/:id/invite/send', to: 'projects#invite_send', as: 'send_invitations'
  post '/projects/:id/:user', to: 'projects#invite_existing', as: 'send_existing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/projects/:id/add_users', to: 'projects#invite_view_users', as: 'invite_users'
end


