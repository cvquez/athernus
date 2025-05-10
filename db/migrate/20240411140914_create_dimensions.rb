class CreateDimensions < ActiveRecord::Migration[7.0]
  def change
    create_table :dimensions do |t|
      t.string :name
      t.string :color, default: '#ffffff'

      t.timestamps
    end
    add_index :dimensions, :name, unique: true
  end
end
