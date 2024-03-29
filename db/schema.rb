# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120131182142) do

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "permission_level"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlist_songs", :force => true do |t|
    t.integer  "song_id"
    t.integer  "position"
    t.integer  "playlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "artist"
    t.string   "album"
  end

  create_table "playlists", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", :force => true do |t|
    t.string   "url"
    t.integer  "service_id"
    t.integer  "user_id"
    t.string   "artwork"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.integer  "group_id"
    t.integer  "is_active"
    t.string   "activation_code"
    t.datetime "last_sign_in"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
