class CreateMaturityLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :maturity_levels do |t|
      t.string :name
      t.text :description
      t.integer :min, default: 15
      t.integer :max, default: 75
      t.string :color, default: '#ffffff'
      t.references :questionnaire_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
