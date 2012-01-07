Postune::Application.routes.draw do
#	root :to => "users#new" 

	resources :users do
		resources :playlists
	end
	
	resources :sessions, :only => [ :new, :create, :destroy ]	
	
	match '/login', :to => "sessions#new"
	match '/logout', :to => "sessions#destroy"
end
 
