class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :url
      t.string :icon

      t.timestamps
    end
  end
end
