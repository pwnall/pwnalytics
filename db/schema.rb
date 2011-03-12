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

ActiveRecord::Schema.define(:version => 20110227091841) do

  create_table "config_vars", :force => true do |t|
    t.string "name",  :null => false
    t.binary "value", :null => false
  end

  add_index "config_vars", ["name"], :name => "index_config_vars_on_name", :unique => true

  create_table "events", :force => true do |t|
    t.integer  "web_property_id",              :null => false
    t.integer  "visitor_id",                   :null => false
    t.integer  "page_id",                      :null => false
    t.integer  "referrer_id",                  :null => false
    t.integer  "browser_time",    :limit => 8, :null => false
    t.integer  "screen_width",                 :null => false
    t.integer  "screen_height",                :null => false
    t.integer  "color_depth",                  :null => false
    t.integer  "document_width",               :null => false
    t.integer  "document_height",              :null => false
    t.integer  "window_x",                     :null => false
    t.integer  "window_y",                     :null => false
    t.string   "ip",                           :null => false
    t.string   "browser_ua",                   :null => false
    t.text     "data_json",                    :null => false
    t.datetime "created_at"
  end

  add_index "events", ["visitor_id", "browser_time"], :name => "index_events_on_visitor_id_and_browser_time"
  add_index "events", ["web_property_id", "page_id", "browser_time"], :name => "index_events_on_web_property_id_and_page_id_and_browser_time"

  create_table "web_pages", :force => true do |t|
    t.integer "web_property_id",                 :null => false
    t.string  "web_property_uid",                :null => false
    t.string  "url",              :limit => 148, :null => false
  end

  add_index "web_pages", ["web_property_id", "url"], :name => "index_web_pages_on_web_property_id_and_url", :unique => true
  add_index "web_pages", ["web_property_uid", "url"], :name => "index_web_pages_on_web_property_uid_and_url", :unique => true

  create_table "web_properties", :force => true do |t|
    t.string "uid",  :null => false
    t.string "name", :null => false
  end

  add_index "web_properties", ["uid"], :name => "index_web_properties_on_uid", :unique => true

  create_table "web_visitors", :force => true do |t|
    t.integer "web_property_id",  :null => false
    t.string  "web_property_uid", :null => false
    t.string  "uid",              :null => false
  end

  add_index "web_visitors", ["web_property_id", "uid"], :name => "index_web_visitors_on_web_property_id_and_uid", :unique => true
  add_index "web_visitors", ["web_property_uid", "uid"], :name => "index_web_visitors_on_web_property_uid_and_uid", :unique => true

end
