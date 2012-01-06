class ChangeSongTypeToServiceId < ActiveRecord::Migration
  def up
	rename_column :songs, :type, :service_id
  end

  def down
	
  end
end
