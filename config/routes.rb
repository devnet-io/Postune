Postune::Application.routes.draw do

	root :to => "player#index" 

	# -------------------
	# Admin Routes
	# -------------------
	resources :songs, :path => "/admin/songs"
	resources :admin, :only => [:index]
	resources :groups, :path => "/admin/groups"
	
	resources :users, :path => "/admin/users" do
		resources :playlists, :only => [:new, :create]
	end
	resources :playlists, :path => "/admin/playlists", :only => [:show, :index, :destroy, :edit, :update] do
		resources :playlist_songs, :path => "song"
	end
	
	match "sort" => "playlists#sort", :via => :post
	  
	# -------------------
	# Session Routes
	# -------------------
	resources :sessions, :only => [:new, :create, :destroy]	
	
	match '/login', :to => "sessions#new"
	match '/logout', :to => "sessions#destroy"
	
	# -------------------
	# General User Routes
	# -------------------
	resources :profile
	match '/activate', :to => "profile#activate"
	match '/register', :to => "profile#new"

	resources :player
	resources :change 
	
	resources :library do
		resources :music
	end
end
 
