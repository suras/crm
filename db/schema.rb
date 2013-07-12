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

ActiveRecord::Schema.define(:version => 20130712063421) do

  create_table "call_lists", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "candidates", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "company"
    t.string   "experience"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.string   "profile_pic_file_name"
    t.string   "profile_pic_content_type"
    t.integer  "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "contact_number"
    t.integer  "team_id"
    t.integer  "user_id"
    t.string   "added_from"
    t.string   "linked_in"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "position"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "candidates_tags", :force => true do |t|
    t.integer "candidate_id"
    t.integer "tag_id"
  end

  create_table "docs", :force => true do |t|
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "excels", :force => true do |t|
    t.string   "excel_sheet_file_name"
    t.string   "excel_sheet_content_type"
    t.integer  "excel_sheet_file_size"
    t.datetime "excel_sheet_updated_at"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "user_id"
    t.string   "status",                   :default => "0"
  end

  create_table "linkedins", :force => true do |t|
    t.string   "linkedin_sheet_file_name"
    t.string   "linkedin_sheet_content_type"
    t.integer  "linkedin_sheet_file_size"
    t.datetime "linkedin_sheet_updated_at"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "notes", :force => true do |t|
    t.integer  "candidate_id"
    t.text     "candidate_note"
    t.integer  "creater_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "notes", ["candidate_id"], :name => "index_notes_on_candidate_id"

  create_table "outlooks", :force => true do |t|
    t.string   "outlook_sheet_file_name"
    t.string   "outlook_sheet_content_type"
    t.integer  "outlook_sheet_file_size"
    t.datetime "outlook_sheet_updated_at"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.string   "amount"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "shortlists", :force => true do |t|
    t.string   "status"
    t.integer  "candidate_id"
    t.integer  "call_list_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "shortlists", ["call_list_id"], :name => "index_shortlists_on_call_list_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "owner_id"
    t.integer  "plan_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "uploads", :force => true do |t|
    t.string   "excel_file_name"
    t.string   "excel_content_type"
    t.integer  "excel_file_size"
    t.datetime "excel_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "user_type"
    t.boolean  "status",                 :default => true
    t.integer  "team_id"
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
