class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.references :questionnaire, null: false, foreign_key: true
      t.references :person, null: true, foreign_key: true, default: nil

      t.timestamps
    end
  end
end
