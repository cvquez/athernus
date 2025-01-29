class CreateBusinessDimensions < ActiveRecord::Migration[7.0]
  def change
    create_table :business_dimensions do |t|
      t.string :name

      t.timestamps
    end
    add_index :business_dimensions, :name, unique: true
  end
end
