Rails.application.routes.draw do
  root :to => "home#index"
  devise_for :users, path: "usuario", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secreto', confirmation: 'verificacion', unlock: 'bloquedo', registration: 'registro', sign_up: 'dejame_entrar' }
  
	resources :users, path: 'usuario' do
	 	resources :portafolios, except: [:index], path_names: { new: "crear", edit: "editar" } do
	 		resources :adjuntos, only: [:destroy]
	 	end
	end
end