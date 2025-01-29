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

ActiveRecord::Schema[6.1].define(version: 2022_05_27_193946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.integer "position", default: 0
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id", null: false
    t.boolean "active"
    t.string "name"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_admins_on_role_id"
  end

  create_table "annual_reports", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "position"
    t.boolean "active"
    t.date "fecha"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "year"
  end

  create_table "atms", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "branch_detail_id"
    t.bigint "local_id"
    t.index ["branch_detail_id"], name: "index_atms_on_branch_detail_id"
    t.index ["local_id"], name: "index_atms_on_local_id"
  end

  create_table "attractives", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "balances", force: :cascade do |t|
    t.string "year"
    t.string "month"
    t.binary "url_pdf"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image_computer"
    t.string "image_mobile"
    t.string "boton_text1"
    t.string "boton_text2"
    t.string "boton_url1"
    t.string "boton_url_2"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "benefit_details", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "active"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "branch_cities", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "branch_details", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "branch_office_id", null: false
    t.index ["branch_office_id"], name: "index_branch_details_on_branch_office_id"
  end

  create_table "branch_offices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.boolean "active"
  end

  create_table "button_details", force: :cascade do |t|
    t.string "text"
    t.string "url"
    t.boolean "active"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "configs", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "ci_ruc"
    t.string "mobile"
    t.string "email"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "estate_cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "estate_types", force: :cascade do |t|
    t.string "name"
    t.string "dimension"
    t.string "farm"
    t.string "cta_cte"
    t.string "location"
    t.string "appraisal"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "estate_city_id", null: false
    t.index ["estate_city_id"], name: "index_estate_types_on_estate_city_id"
  end

  create_table "estates", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "footer_details", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "footer_id", null: false
    t.index ["footer_id"], name: "index_footer_details_on_footer_id"
  end

  create_table "footers", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "government_corporates", force: :cascade do |t|
    t.string "title_button"
    t.integer "position"
    t.boolean "active"
    t.binary "url_pdf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "institutional_releases", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "living_place_attractives", force: :cascade do |t|
    t.string "def"
    t.string "index"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "living_place_attrs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "living_place_id", null: false
    t.bigint "attractive_id", null: false
    t.index ["attractive_id"], name: "index_living_place_attrs_on_attractive_id"
    t.index ["living_place_id"], name: "index_living_place_attrs_on_living_place_id"
  end

  create_table "living_places", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "portada"
    t.string "caracteristicas"
    t.decimal "precio_total"
    t.decimal "cuota"
    t.decimal "plazo"
    t.boolean "destacado"
    t.integer "peso"
    t.string "titulo_proyecto"
    t.integer "habitaciones"
    t.boolean "piscina"
    t.decimal "precio_base"
    t.string "longitud"
    t.string "latitud"
    t.string "etiqueta"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "type_term_id", null: false
    t.bigint "type_living_place_id", null: false
    t.bigint "zone_living_place_id", null: false
    t.string "fotos"
    t.integer "position"
    t.index ["type_living_place_id"], name: "index_living_places_on_type_living_place_id"
    t.index ["type_term_id"], name: "index_living_places_on_type_term_id"
    t.index ["zone_living_place_id"], name: "index_living_places_on_zone_living_place_id"
  end

  create_table "locals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "address"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "menu_details", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "menu_id", null: false
    t.index ["menu_id"], name: "index_menu_details_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "preferential_attention_details", force: :cascade do |t|
    t.string "text_tab"
    t.string "description"
    t.boolean "active"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "private_bankings", force: :cascade do |t|
    t.string "image"
    t.string "preferential_attention"
    t.string "text_tarjeta_credito"
    t.string "text_tarjeta_adicional"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_details", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "position"
    t.boolean "active"
    t.string "image_computer"
    t.string "image_mobile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.string "icon_normal"
    t.string "icon_active"
    t.index ["product_id"], name: "index_product_details_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "boton_text"
    t.string "boton_url"
    t.integer "position"
    t.boolean "active"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "qualification_risks", force: :cascade do |t|
    t.string "description"
    t.binary "url_pdf"
    t.string "year"
    t.string "month"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "resolution_releases", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.boolean "product_create"
    t.boolean "product_read"
    t.boolean "product_update"
    t.boolean "product_delete"
    t.boolean "banner_create"
    t.boolean "banner_read"
    t.boolean "banner_update"
    t.boolean "banner_delete"
    t.boolean "admin_create"
    t.boolean "admin_read"
    t.boolean "admin_update"
    t.boolean "admin_delete"
    t.boolean "role_create"
    t.boolean "role_read"
    t.boolean "role_update"
    t.boolean "role_delete"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sub_product_details", force: :cascade do |t|
    t.string "name"
    t.string "description_short"
    t.string "description_long"
    t.string "requisito"
    t.string "info"
    t.integer "position"
    t.string "image_description"
    t.string "image"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sub_product_id", null: false
    t.boolean "private_banking", default: false
    t.index ["sub_product_id"], name: "index_sub_product_details_on_sub_product_id"
  end

  create_table "sub_products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image_computer"
    t.string "image_mobile"
    t.integer "position"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_detail_id", null: false
    t.string "icon_normal"
    t.string "icon_active"
    t.string "image"
    t.index ["product_detail_id"], name: "index_sub_products_on_product_detail_id"
  end

  create_table "tariffs", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.binary "url_pdf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tausers", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "local_id"
    t.bigint "branch_detail_id"
    t.index ["branch_detail_id"], name: "index_tausers_on_branch_detail_id"
    t.index ["local_id"], name: "index_tausers_on_local_id"
  end

  create_table "timelines", force: :cascade do |t|
    t.string "year"
    t.string "description"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "titles", force: :cascade do |t|
    t.string "description"
    t.string "boton_text"
    t.string "boton_url"
    t.integer "position"
    t.boolean "active"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "type_living_places", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "type_terms", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variab_twos", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "value"
  end

  create_table "variable2s", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variable_twos", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "social_media"
    t.integer "position"
    t.boolean "active"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "variabls", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "zone_living_places", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "roles"
  add_foreign_key "atms", "branch_details"
  add_foreign_key "atms", "locals"
  add_foreign_key "branch_details", "branch_offices"
  add_foreign_key "estate_types", "estate_cities"
  add_foreign_key "footer_details", "footers"
  add_foreign_key "living_place_attrs", "attractives"
  add_foreign_key "living_place_attrs", "living_places"
  add_foreign_key "living_places", "type_living_places"
  add_foreign_key "living_places", "type_terms"
  add_foreign_key "living_places", "zone_living_places"
  add_foreign_key "menu_details", "menus"
  add_foreign_key "product_details", "products"
  add_foreign_key "sub_product_details", "sub_products"
  add_foreign_key "sub_products", "product_details"
  add_foreign_key "tausers", "branch_details"
  add_foreign_key "tausers", "locals"
end
