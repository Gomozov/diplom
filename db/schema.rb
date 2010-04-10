# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100206162419) do

  create_table "devices", :force => true do |t|
    t.string   "device_code"
    t.string   "device_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_fields", :force => true do |t|
    t.integer  "report_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", :force => true do |t|
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
