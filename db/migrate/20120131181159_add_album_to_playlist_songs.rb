class AddAlbumToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :album, :string
  end
end
