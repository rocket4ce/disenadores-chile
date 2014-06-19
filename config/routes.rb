Rails.application.routes.draw do

  resources :perfiles, only: [:show, :update]
  resources :blogs
  get 'comentarios/create'
  get 'comentarios/destroy'

  root :to => "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }, path: "usuario", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secreto', confirmation: 'verificacion', unlock: 'bloquedo', registration: 'registro', sign_up: 'dejame_entrar' }
  
  resources :users, path: 'usuario' do
    member do
        post :follow
      end
    resources :portafolios, except: [:index], path_names: { new: "crear", edit: "editar" } do
      collection do
            post 'sort'
          end
      resources :adjuntos, only: [:destroy]
      resources :comentarios, only: [:create, :destroy]
    end
  end
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
end