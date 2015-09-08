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

ActiveRecord::Schema.define(:version => 20141008115349) do

  create_table "administrators", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "last_login_at"
    t.integer  "login_count",        :default => 0
    t.boolean  "super_admin",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "css"
    t.string   "perishable_token",   :default => "",    :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  add_index "administrators", ["perishable_token"], :name => "index_administrators_on_perishable_token"

  create_table "administrators_roles", :id => false, :force => true do |t|
    t.integer "administrator_id"
    t.integer "role_id"
  end

  create_table "articles", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "main_content"
    t.date     "date",               :default => '2010-11-23'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.boolean  "highlight"
    t.string   "cached_slug"
  end

  create_table "blog_entries", :force => true do |t|
    t.string   "headline"
    t.text     "summary"
    t.text     "main_content"
    t.date     "date",               :default => '2010-11-23'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
  end

  create_table "case_studies", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "main_content"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.integer  "testimonial_id"
    t.boolean  "highlight"
    t.integer  "service_id"
    t.integer  "page_content_id"
    t.string   "cached_slug"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  create_table "cost_calculations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_distribution_count", :default => 0,     :null => false
    t.integer  "document_archive_count",      :default => 0,     :null => false
    t.integer  "document_retrieval_count",    :default => 0,     :null => false
    t.integer  "document_callbacks_count",    :default => 0,     :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                     :default => true
    t.integer  "position",                    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "document_process_count",      :default => 0,     :null => false
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.boolean  "call_back",                   :default => false
  end

  create_table "cross_sells", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  create_table "documents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "document_content_type"
    t.string   "document_file_name"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.text     "question"
    t.text     "answer"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.integer  "position",         :default => 0
    t.boolean  "super_admin_only", :default => false
    t.string   "css_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "menu",             :default => true
    t.boolean  "permission",       :default => true
    t.string   "location"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",         :default => false
    t.datetime "recycled_at"
    t.boolean  "display",          :default => true
  end

  create_table "features_roles", :id => false, :force => true do |t|
    t.integer "feature_id"
    t.integer "role_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "gallery_images", :force => true do |t|
    t.integer  "gallery_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
  end

  create_table "glossary_items", :force => true do |t|
    t.string   "word"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "green_arena_texts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "home_highlights", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                 :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                  :default => true
    t.integer  "position",                 :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.string   "external_link"
    t.boolean  "external_link_new_window", :default => true
  end

  create_table "images", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "image_content_type"
    t.string   "image_file_name"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "main_content"
    t.date     "closing_date"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",                      :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                       :default => true
    t.integer  "position",                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "information_pack_file_name"
    t.string   "information_pack_content_type"
    t.integer  "information_pack_file_size"
    t.datetime "information_pack_updated_at"
    t.string   "information_pack_alt"
  end

  create_table "makes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
  end

  create_table "page_contents", :force => true do |t|
    t.string   "navigation_title"
    t.string   "url_title"
    t.string   "title"
    t.integer  "page_node_id"
    t.boolean  "completed",        :default => false
    t.boolean  "published",        :default => false
    t.boolean  "active",           :default => false
    t.datetime "last_updated_at",  :default => '2010-04-29 08:55:42'
    t.text     "main_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "meta_description"
    t.text     "meta_tags"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",         :default => false
    t.datetime "recycled_at"
    t.boolean  "display",          :default => true
    t.integer  "position",         :default => 0
  end

  create_table "page_nodes", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "parent_id"
    t.integer  "position",              :default => 0
    t.string   "action"
    t.string   "controller"
    t.string   "model"
    t.string   "layout"
    t.boolean  "display",               :default => false
    t.boolean  "display_in_navigation", :default => true
    t.boolean  "can_be_moved",          :default => true
    t.boolean  "can_be_edited",         :default => true
    t.boolean  "can_be_deleted",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_key"
    t.string   "stylesheet"
    t.boolean  "can_have_children",     :default => true
    t.boolean  "special_menu",          :default => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",              :default => false
    t.datetime "recycled_at"
    t.boolean  "is_a_service"
  end

  create_table "products", :force => true do |t|
    t.integer  "make_id"
    t.integer  "category_id"
    t.string   "name"
    t.text     "summary"
    t.text     "description"
    t.string   "video"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",               :default => false
    t.datetime "recycled_at"
    t.boolean  "display",                :default => true
    t.integer  "position",               :default => 0
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.string   "datasheet_file_name"
    t.string   "datasheet_content_type"
    t.integer  "datasheet_file_size"
    t.datetime "datasheet_updated_at"
    t.string   "datasheet_alt"
    t.boolean  "highlight"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "all_features", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",     :default => false
    t.datetime "recycled_at"
    t.boolean  "display",      :default => true
  end

  create_table "site_settings", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.boolean  "super_admin_only", :default => true
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",         :default => false
    t.datetime "recycled_at"
    t.boolean  "display",          :default => true
    t.string   "input_type",       :default => "text_area"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "staff_testimonials", :force => true do |t|
    t.text     "quote"
    t.string   "author"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",    :default => false
    t.datetime "recycled_at"
    t.boolean  "display",     :default => true
    t.integer  "position",    :default => 0
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "testimonials", :force => true do |t|
    t.text     "quote"
    t.string   "author"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",           :default => false
    t.datetime "recycled_at"
    t.boolean  "display",            :default => true
    t.integer  "position",           :default => 0
    t.boolean  "highlight"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "image_alt"
    t.integer  "service_id"
  end

  create_table "white_papers", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "recycled",              :default => false
    t.datetime "recycled_at"
    t.boolean  "display",               :default => true
    t.integer  "position",              :default => 0
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.string   "document_alt"
  end

end
