class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :group_id
      t.integer :is_active
      t.string :activation_code
      t.datetime :last_sign_in

      t.timestamps
    end
  end
end
