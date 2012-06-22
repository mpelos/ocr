# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120621011820) do

  create_table "character_data", :force => true do |t|
    t.string   "character"
    t.string   "quadrants_quantity"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "character_data", ["quadrants_quantity"], :name => "index_character_data_on_quadrants_quantity"

  create_table "quadrants", :force => true do |t|
    t.integer  "character_data_id"
    t.float    "density"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
