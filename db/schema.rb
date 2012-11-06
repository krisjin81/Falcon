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

ActiveRecord::Schema.define(:version => 20121106005407) do

  create_table "admin_profiles", :force => true do |t|
    t.integer  "admin_id"
    t.string   "username",   :limit => 50
    t.string   "first_name", :limit => 50
    t.string   "last_name",  :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "admin_profiles", ["first_name"], :name => "index_admin_profiles_on_first_name"
  add_index "admin_profiles", ["last_name"], :name => "index_admin_profiles_on_last_name"
  add_index "admin_profiles", ["username"], :name => "index_admin_profiles_on_username"

  create_table "age_groups", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "audiences", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "avatars", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image"
  end

  create_table "blogposts", :force => true do |t|
    t.string   "content",    :null => false
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blogposts", ["account_id", "created_at"], :name => "index_blogposts_on_account_id_and_created_at"

  create_table "business_profiles", :force => true do |t|
    t.integer  "affiliate_id"
    t.string   "business_name",      :limit => 50
    t.integer  "business_type",      :limit => 1
    t.string   "contact_first_name", :limit => 50
    t.string   "contact_last_name",  :limit => 50
    t.string   "contact_email"
    t.text     "about"
    t.string   "website"
    t.integer  "country_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "country"
  end

  create_table "business_profiles_age_groups", :force => true do |t|
    t.integer "business_profile_id"
    t.integer "age_group_id"
  end

  create_table "business_profiles_audiences", :force => true do |t|
    t.integer "business_profile_id"
    t.integer "audience_id"
  end

  create_table "business_profiles_styles", :force => true do |t|
    t.integer "business_profile_id"
    t.integer "style_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "body",             :limit => 1000
    t.integer  "author_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "countries", :force => true do |t|
    t.string "name", :limit => 50
    t.string "iso2", :limit => 2
    t.string "iso3", :limit => 3
  end

  add_index "countries", ["name"], :name => "index_countries_on_name"

  create_table "invitees", :force => true do |t|
    t.integer  "account_id"
    t.integer  "showcase_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "invitees", ["account_id", "showcase_id"], :name => "index_invitees_on_account_id_and_showcase_id"

  create_table "language_settings", :force => true do |t|
    t.integer "user_id"
    t.string  "locale",  :limit => 3
  end

  create_table "likes", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "likes", ["profile_id", "likeable_type", "likeable_id"], :name => "index_likes_on_profile_id_and_likeable_type_and_likeable_id"

  create_table "pictures", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "title"
    t.text     "dressing_tips"
    t.string   "brands"
    t.string   "cost"
    t.string   "where_to_buy"
    t.integer  "gender",          :limit => 1
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "original_image"
    t.string   "filter",          :limit => 20
    t.string   "formatted_image"
    t.string   "style"
    t.boolean  "s1"
    t.boolean  "s2"
    t.boolean  "s3"
  end

  create_table "pictures_showcases", :id => false, :force => true do |t|
    t.integer "picture_id"
    t.integer "showcase_id"
  end

  create_table "pictures_styles", :force => true do |t|
    t.integer "picture_id"
    t.integer "style_id"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "account_id"
    t.string   "username",   :limit => 50
    t.string   "first_name", :limit => 50
    t.string   "last_name",  :limit => 50
    t.date     "birth_date"
    t.integer  "country_id"
    t.integer  "gender",     :limit => 1
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "country"
  end

  add_index "profiles", ["account_id"], :name => "index_profiles_on_account_id"
  add_index "profiles", ["first_name"], :name => "index_profiles_on_first_name"
  add_index "profiles", ["last_name"], :name => "index_profiles_on_last_name"
  add_index "profiles", ["username"], :name => "index_profiles_on_username", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "showcases", :force => true do |t|
    t.string   "name",                                :null => false
    t.string   "content"
    t.boolean  "publicly_visible", :default => true,  :null => false
    t.integer  "account_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "default",          :default => false
    t.integer  "cover_picture_id"
  end

  add_index "showcases", ["account_id", "created_at"], :name => "index_showcases_on_account_id_and_created_at"

  create_table "styles", :force => true do |t|
    t.string   "name",       :limit => 50
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "type"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "admin_level"
    t.string   "external_user_id",       :limit => 50
    t.string   "provider",               :limit => 20
    t.string   "username"
    t.string   "free_member_level"
    t.string   "affiliate_member_level"
    t.boolean  "active"
  end

  add_index "users", ["confirmed_at"], :name => "index_users_on_confirmed_at"
  add_index "users", ["created_at"], :name => "index_users_on_created_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_sign_in_at"], :name => "index_users_on_last_sign_in_at"
  add_index "users", ["provider", "external_user_id"], :name => "index_users_on_provider_and_external_user_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["type", "confirmed_at"], :name => "index_users_on_type_and_confirmed_at"
  add_index "users", ["type", "created_at"], :name => "index_users_on_type_and_created_at"
  add_index "users", ["type", "email"], :name => "index_users_on_type_and_email"
  add_index "users", ["type", "last_sign_in_at"], :name => "index_users_on_type_and_last_sign_in_at"
  add_index "users", ["type", "provider", "email"], :name => "index_users_on_type_and_provider_and_email"
  add_index "users", ["type", "provider", "id"], :name => "index_users_on_type_and_provider_and_id"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
