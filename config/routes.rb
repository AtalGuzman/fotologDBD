Rails.application.routes.draw do


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :amigos

  resources :fotos do
    #Sub-recursos de las fotos, no tienen sentido hasta que se anidad a una foto
    resources :calificacions
    resources :comentarios  , only: [:create,:update,:destroy]
  end
  devise_for :usuarios

  resources :usuario do
    resources :amigos
  end

  get '/usuarios/:id', to: 'usuario#show'
  get "/usuarios/:id/amigos", to: 'usuario#mis_amigos'
  get "/usuarios/:id/fotos", to: 'usuario#mis_fotos'
  get "/anonimo", to: 'fotos#anonimo'

  root 'welcome#index'

end
