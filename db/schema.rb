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

ActiveRecord::Schema.define(:version => 20110610151737) do

  create_table "call_histories", :force => true do |t|
    t.integer  "ticket_id",        :null => false
    t.integer  "wicket_id",        :null => false
    t.integer  "status_ticket_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locals", :force => true do |t|
    t.string   "des_local",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panels", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "ip",         :null => false
    t.string   "user",       :null => false
    t.integer  "status_id",  :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "value",                        :null => false
    t.string   "user",                         :null => false
    t.integer  "status_id",                    :null => false
    t.integer  "local_id",                     :null => false
    t.integer  "places_ticket_type_groups_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places_ticket_type_groups", :id => false, :force => true do |t|
    t.integer "ticket_type_group_id", :null => false
    t.integer "place_id",             :null => false
  end

  create_table "status_tickets", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "acronym",    :null => false
    t.string   "user",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "user",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_type_groups", :force => true do |t|
    t.string   "value",                        :null => false
    t.string   "user",                         :null => false
    t.integer  "status_id",                    :null => false
    t.integer  "places_ticket_type_groups_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_types", :force => true do |t|
    t.string   "value",                :null => false
    t.string   "acronym",              :null => false
    t.string   "user",                 :null => false
    t.integer  "ticket_type_group_id", :null => false
    t.integer  "status_id",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "priority"
  end

  create_table "tickets", :force => true do |t|
    t.string   "value",            :null => false
    t.integer  "status_ticket_id", :null => false
    t.integer  "ticket_type_id",   :null => false
    t.integer  "place_id",         :null => false
    t.integer  "totem_id",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "totems", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "ip",         :null => false
    t.string   "user",       :null => false
    t.integer  "status_id",  :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wickets", :force => true do |t|
    t.string   "value",                :null => false
    t.string   "user",                 :null => false
    t.integer  "status_id",            :null => false
    t.integer  "place_id",             :null => false
    t.integer  "ticket_type_group_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guidance"
    t.boolean  "priority"
  end

end
