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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190512215530) do

  create_table "properties", force: :cascade do |t|
    t.string  "name"
    t.string  "address"
    t.string  "tenant_name"
    t.string  "tenant_email"
    t.string  "tenant_phone_number"
    t.float   "security_deposit"
    t.float   "rent"
    t.string  "lease_starting_date"
    t.string  "lease_ending_date"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "password_digest"
  end

end
