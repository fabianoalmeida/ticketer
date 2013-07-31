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

ActiveRecord::Schema.define(:version => 20130619180955) do

  create_table "call_histories", :force => true do |t|
    t.integer  "ticket_id",        :null => false
    t.integer  "wicket_id",        :null => false
    t.integer  "status_ticket_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "call_histories", ["created_at"], :name => "index_call_histories_on_created_at"
  add_index "call_histories", ["status_ticket_id"], :name => "index_call_histories_on_status_ticket_id"
  add_index "call_histories", ["ticket_id"], :name => "index_call_histories_on_ticket_id"
  add_index "call_histories", ["wicket_id"], :name => "index_call_histories_on_wicket_id"

  create_table "locals", :force => true do |t|
    t.string   "des_local",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "panels", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "ip",         :null => false
    t.string   "user",       :null => false
    t.integer  "status_id",  :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "panels", ["place_id"], :name => "index_panels_on_place_id"
  add_index "panels", ["slug"], :name => "index_panels_on_slug", :unique => true
  add_index "panels", ["status_id"], :name => "index_panels_on_status_id"

  create_table "places", :force => true do |t|
    t.string   "value",                                           :null => false
    t.string   "user",                                            :null => false
    t.integer  "status_id",                                       :null => false
    t.integer  "local_id",                                        :null => false
    t.integer  "places_ticket_type_groups_id"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.boolean  "sequential_by_type_group",     :default => false, :null => false
    t.string   "slug"
  end

  add_index "places", ["local_id"], :name => "index_places_on_local_id"
  add_index "places", ["places_ticket_type_groups_id"], :name => "index_places_on_places_ticket_type_groups_id"
  add_index "places", ["slug"], :name => "index_places_on_slug", :unique => true
  add_index "places", ["status_id"], :name => "index_places_on_status_id"

  create_table "places_ticket_type_groups", :id => false, :force => true do |t|
    t.integer "ticket_type_group_id", :null => false
    t.integer "place_id",             :null => false
  end

  add_index "places_ticket_type_groups", ["place_id"], :name => "index_places_ticket_type_groups_on_place_id"
  add_index "places_ticket_type_groups", ["ticket_type_group_id"], :name => "index_places_ticket_type_groups_on_ticket_type_group_id"

  create_table "printers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "template"
  end

  add_index "printers", ["slug"], :name => "index_printers_on_slug", :unique => true

  create_table "reference_groups_wickets", :id => false, :force => true do |t|
    t.integer "ticket_type_group_id"
    t.integer "wicket_id"
  end

  add_index "reference_groups_wickets", ["ticket_type_group_id"], :name => "index_reference_groups_wickets_on_ticket_type_group_id"
  add_index "reference_groups_wickets", ["wicket_id"], :name => "index_reference_groups_wickets_on_wicket_id"

  create_table "status_tickets", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "acronym",    :null => false
    t.string   "user",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "status_tickets", ["acronym"], :name => "index_status_tickets_on_acronym"
  add_index "status_tickets", ["value"], :name => "index_status_tickets_on_value"

  create_table "statuses", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "user",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "statuses", ["value"], :name => "index_statuses_on_value"

  create_table "ticket_type_groups", :force => true do |t|
    t.string   "value",                        :null => false
    t.string   "user",                         :null => false
    t.integer  "status_id",                    :null => false
    t.integer  "places_ticket_type_groups_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "ticket_type_groups", ["places_ticket_type_groups_id"], :name => "index_ticket_type_groups_on_places_ticket_type_groups_id"
  add_index "ticket_type_groups", ["status_id"], :name => "index_ticket_type_groups_on_status_id"

  create_table "ticket_type_groups_wickets", :id => false, :force => true do |t|
    t.integer "ticket_type_group_id"
    t.integer "wicket_id"
  end

  add_index "ticket_type_groups_wickets", ["ticket_type_group_id"], :name => "index_ticket_type_groups_wickets_on_ticket_type_group_id"
  add_index "ticket_type_groups_wickets", ["wicket_id"], :name => "index_ticket_type_groups_wickets_on_wicket_id"

  create_table "ticket_types", :force => true do |t|
    t.string   "value",                :null => false
    t.string   "acronym",              :null => false
    t.string   "user",                 :null => false
    t.integer  "ticket_type_group_id", :null => false
    t.integer  "status_id",            :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.boolean  "priority"
  end

  add_index "ticket_types", ["acronym"], :name => "index_ticket_types_on_acronym"
  add_index "ticket_types", ["priority"], :name => "index_ticket_types_on_priority"
  add_index "ticket_types", ["status_id"], :name => "index_ticket_types_on_status_id"
  add_index "ticket_types", ["ticket_type_group_id"], :name => "index_ticket_types_on_ticket_type_group_id"

  create_table "tickets", :force => true do |t|
    t.string   "value",            :null => false
    t.integer  "status_ticket_id", :null => false
    t.integer  "ticket_type_id",   :null => false
    t.integer  "place_id",         :null => false
    t.integer  "totem_id",         :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "state"
  end

  add_index "tickets", ["created_at"], :name => "index_tickets_on_created_at"
  add_index "tickets", ["place_id"], :name => "index_tickets_on_place_id"
  add_index "tickets", ["state"], :name => "index_tickets_on_state"
  add_index "tickets", ["status_ticket_id"], :name => "index_tickets_on_status_ticket_id"
  add_index "tickets", ["ticket_type_id"], :name => "index_tickets_on_ticket_type_id"
  add_index "tickets", ["totem_id"], :name => "index_tickets_on_totem_id"

  create_table "totems", :force => true do |t|
    t.string   "value",      :null => false
    t.string   "ip",         :null => false
    t.string   "user",       :null => false
    t.integer  "status_id",  :null => false
    t.integer  "place_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
    t.integer  "printer_id"
  end

  add_index "totems", ["place_id"], :name => "index_totems_on_place_id"
  add_index "totems", ["printer_id"], :name => "index_totems_on_printer_id"
  add_index "totems", ["slug"], :name => "index_totems_on_slug", :unique => true
  add_index "totems", ["status_id"], :name => "index_totems_on_status_id"

  create_table "wickets", :force => true do |t|
    t.string   "value",                           :null => false
    t.string   "user",                            :null => false
    t.integer  "status_id",                       :null => false
    t.integer  "place_id",                        :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "guidance"
    t.boolean  "priority"
    t.boolean  "second_level", :default => false, :null => false
    t.boolean  "alternate",    :default => false
    t.string   "slug"
  end

  add_index "wickets", ["created_at"], :name => "index_wickets_on_created_at"
  add_index "wickets", ["place_id"], :name => "index_wickets_on_place_id"
  add_index "wickets", ["slug"], :name => "index_wickets_on_slug", :unique => true
  add_index "wickets", ["status_id"], :name => "index_wickets_on_status_id"

end
