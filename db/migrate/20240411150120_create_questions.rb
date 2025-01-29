class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.text :content
      t.references :questionnaire_type, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :focus_area, null: false, foreign_key: true
      t.references :business_dimension, null: true, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
