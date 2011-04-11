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

ActiveRecord::Schema.define(:version => 20110411012531) do

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

  add_index "ticket_types", ["status_id"], :name => "index_ticket_types_on_status_id"

  create_table "tickets", :force => true do |t|
    t.string   "value"
    t.integer  "ticket_type_id"
    t.integer  "status_ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["status_ticket_id"], :name => "index_tickets_on_status_ticket_id"
  add_index "tickets", ["ticket_type_id"], :name => "index_tickets_on_ticket_type_id"

  create_table "wickets", :force => true do |t|
    t.string   "value"
    t.integer  "guidance_id"
    t.integer  "status_id"
    t.string   "user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
