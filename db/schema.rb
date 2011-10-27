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

ActiveRecord::Schema.define(:version => 20111026105853) do

  create_table "flood_levels", :force => true do |t|
    t.integer  "zone_id",    :null => false
    t.datetime "at",         :null => false
    t.integer  "level",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flood_levels", ["zone_id", "at"], :name => "index_flood_levels_on_zone_id_and_at"
  add_index "flood_levels", ["zone_id"], :name => "index_flood_levels_on_zone_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "reports", :force => true do |t|
    t.integer  "zone_id",    :null => false
    t.boolean  "flooded"
    t.string   "author"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
  end

  add_index "reports", ["zone_id", "created_at"], :name => "index_reports_on_zone_id_and_created_at"
  add_index "reports", ["zone_id"], :name => "index_reports_on_zone_id"

  create_table "zones", :force => true do |t|
    t.integer  "reports_count",  :default => 0, :null => false
    t.integer  "positive_count", :default => 0, :null => false
    t.integer  "negative_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
