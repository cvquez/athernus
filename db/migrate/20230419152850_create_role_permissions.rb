class CreateRolePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :role_permissions do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true
      t.boolean :allowed, default: true

      t.timestamps
    end
    add_index :role_permissions, %i[role_id permission_id], unique: true
  end
end
