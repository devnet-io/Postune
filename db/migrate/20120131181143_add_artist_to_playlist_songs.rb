class AddArtistToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :artist, :string
  end
end
