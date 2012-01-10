class AddExternalIdToSongs < ActiveRecord::Migration
	def up
		add_column :songs, :external_id, :string
	end
	def down
		remove_column :songs, :external_id
	end
end
