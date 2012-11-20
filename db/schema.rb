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

ActiveRecord::Schema.define(:version => 20121119003525) do

  create_table "posts", :force => true do |t|
    t.integer  "year"
    t.string   "title"
    t.string   "path"
    t.integer  "path_mtime"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.text     "image"
  end

  create_table "tags", :force => true do |t|
    t.string  "text"
    t.integer "posts_counter"
  end

  create_table "tags_posts", :force => true do |t|
    t.integer "tag_id",  :null => false
    t.integer "post_id", :null => false
  end

  create_table "wikipedia_articles", :force => true do |t|
    t.string "title"
  end

  create_table "wikipedia_posts", :force => true do |t|
    t.integer "wikipedia_article_id", :null => false
    t.integer "post_id",              :null => false
  end

end
