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


ActiveRecord::Schema.define(version: 20140330000546) do

  create_table "blood_oxygen_readings", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_id"
    t.integer  "bo_sensor_id"
    t.float    "bo_perc"
    t.datetime "reading_time"
  end

  create_table "blood_pressure_readings", force: true do |t|
    t.integer  "patient_id"
    t.integer  "bp_sensor_id"
    t.integer  "systolic_bp"
    t.integer  "diastolic_bp"
    t.datetime "reading_time"
    t.datetime "created_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emas", force: true do |t|
    t.integer  "patient_id"
    t.float    "temperature"
    t.string   "sodium_level"
    t.string   "quality_of_sleep"
    t.datetime "reading_time"
    t.datetime "created_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heart_rate_readings", force: true do |t|
    t.integer  "patient_id"
    t.integer  "hr_sensor_id"
    t.float    "heart_rate"
    t.float    "heart_rate_variability"
    t.datetime "reading_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patients", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "physicians", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "threshold_values", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_id"
    t.float    "bo_perc"
    t.integer  "systolic_bp"
    t.integer  "diastolic_bp"
    t.float    "heart_rate"
    t.float    "heart_rate_variability"
    t.float    "weight"
    t.float    "hydration"
  end

  create_table "weight_readings", force: true do |t|
    t.integer  "patient_id"
    t.float    "weight"
    t.float    "hydration"
    t.datetime "reading_time"
    t.datetime "created_date"
    t.integer  "weight_monitor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
