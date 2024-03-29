# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_221_005_095_024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'
  enable_extension 'uuid-ossp'

  create_table 'apis', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.integer 'api_type'
    t.integer 'api_method'
    t.string 'api_url'
    t.uuid 'client_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'document_type'
    t.index ['client_id'], name: 'index_apis_on_client_id'
  end

  create_table 'clients', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.string 'company_name'
    t.string 'username'
    t.string 'password'
    t.text 'token'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'api_token'
    t.string 'ftp_host'
    t.string 'ftp_port'
    t.string 'ftp_user'
    t.string 'ftp_password'
    t.string 'notify_email'
  end

  create_table 'document_groups', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'title'
    t.uuid 'vendor_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'downloaded', default: false
    t.index ['vendor_id'], name: 'index_document_groups_on_vendor_id'
  end

  create_table 'documents', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.json 'data'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.uuid 'document_group_id'
    t.index ['document_group_id'], name: 'index_documents_on_document_group_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'vendors', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'vendor_code'
    t.uuid 'client_id', null: false
    t.datetime 'created_at', precision: 6, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    t.datetime 'updated_at', precision: 6, default: -> { 'CURRENT_TIMESTAMP' }, null: false
    t.string 'name'
    t.index ['client_id'], name: 'index_vendors_on_client_id'
  end

  add_foreign_key 'document_groups', 'vendors'
  add_foreign_key 'vendors', 'clients'
end
