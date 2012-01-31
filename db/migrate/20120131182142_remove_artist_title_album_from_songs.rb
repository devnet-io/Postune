class RemoveArtistTitleAlbumFromSongs < ActiveRecord::Migration
  def up
  	remove_column :songs, :title
  	remove_column :songs, :artist
  	remove_column :songs, :album 
  end

  def down
  	change_table :songs do |t| 
  		t.string :title
  		t.string :artist
  		t.string :album
  	end
  end
end
