class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :controller, null: false
      t.string :action, default: ''
      t.boolean :deleted, default: false
      t.timestamps
    end
    add_index :permissions, %i[controller action], unique: true
  end
end
