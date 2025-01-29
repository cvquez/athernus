class CreateQuestionnaires < ActiveRecord::Migration[7.0]
  def change
    create_table :questionnaires do |t|
      t.references :questionnaire_type, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.boolean :status

      t.timestamps
    end
    add_index :questionnaires, :slug, unique: true
  end
end
