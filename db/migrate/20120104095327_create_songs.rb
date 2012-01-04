class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.string :url
      t.integer :type
      t.integer :user_id
      t.string :artwork

      t.timestamps
    end
  end
end
