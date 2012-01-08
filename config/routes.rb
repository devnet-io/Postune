Postune::Application.routes.draw do

#	root :to => "users#new" 

	# ------------
	# Admin Routes
	# ------------
	resources :songs, :path => "/admin/songs"
	resources :admin, :only => [ :index ]
	
	resources :users, :path => "/admin/users" do 
		resources :playlists do
			resources :playlist_songs, :path => "song" 
		end
	end
	
	resources :sessions, :only => [ :new, :create, :destroy ]	
	
	match '/login', :to => "sessions#new"
	match '/logout', :to => "sessions#destroy"
end
 
