json.extract! admin, :id, :name, :email, :password, :password_confirmation, :role_id, :active, :created_at, :updated_at
json.url admin_url(admin, format: :json)
