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

ActiveRecord::Schema.define(:version => 20110411192746) do

  create_table "call_histories", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "wicket_id"
    t.integer  "call_history_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "call_history_types", :force => true do |t|
    t.string   "value"
    t.string   "acronym"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guidances", :force => true do |t|
    t.string   "value"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locals", :force => true do |t|
    t.string   "des_local"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panels", :force => true do |t|
    t.string   "value"
    t.string   "ip"
    t.string   "user"
    t.integer  "status_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "value"
    t.string   "user"
    t.integer  "status_id"
    t.integer  "local_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "status_tickets", :force => true do |t|
    t.string   "value"
    t.string   "acronym"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "value"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_types", :force => true do |t|
    t.string   "value"
    t.string   "acronym"
    t.string   "user"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.string   "value"
    t.integer  "status_ticket_id"
    t.integer  "ticket_type_id"
    t.integer  "place_id"
    t.integer  "totem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "totems", :force => true do |t|
    t.string   "value"
    t.string   "ip"
    t.string   "user"
    t.integer  "status_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wickets", :force => true do |t|
    t.string   "value"
    t.string   "user"
    t.integer  "guidance_id"
    t.integer  "status_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
