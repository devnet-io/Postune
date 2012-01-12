Postune::Application.routes.draw do

	root :to => "profile#new" 

	# -------------------
	# Admin Routes
	# -------------------
	resources :songs, :path => "/admin/songs", :only => [:show, :index, :edit]
	resources :admin, :only => [ :index ]
	resources :groups, :path => "/admin/groups"
	
	resources :users, :path => "/admin/users" do 
		resources :playlists do
			resources :playlist_songs, :path => "song" 
		end
	end
	  
	# -------------------
	# Session Routes
	# -------------------
	resources :sessions, :only => [ :new, :create, :destroy ]	
	
	match '/login', :to => "sessions#new"
	match '/logout', :to => "sessions#destroy"
	
	# -------------------
	# General User Routes
	# -------------------
	resources :profile
	
end
 
