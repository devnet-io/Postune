class AddTitleToPlaylistSongs < ActiveRecord::Migration
  def change
    add_column :playlist_songs, :title, :string
  end
end
