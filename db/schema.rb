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

ActiveRecord::Schema.define(:version => 20130514012923) do

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "result_browse_logs", :force => true do |t|
    t.string   "visit_id"
    t.integer  "page"
    t.integer  "position"
    t.integer  "page_size"
    t.integer  "result_position"
    t.string   "search_keyword"
    t.string   "browser_type"
    t.integer  "domain_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "search_logs", :force => true do |t|
    t.string   "visit_id"
    t.string   "keyword"
    t.integer  "search_result_count"
    t.string   "browser_type"
    t.integer  "domain_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

end
