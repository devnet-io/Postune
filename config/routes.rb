Postune::Application.routes.draw do

#	root :to => "users#new" 
	resources :songs
	resources :users do
		resources :playlists do
			resources :playlist_songs, :path => "song" 
		end
	end
	
	resources :sessions, :only => [ :new, :create, :destroy ]	
	
	match '/login', :to => "sessions#new"
	match '/logout', :to => "sessions#destroy"
end
 
