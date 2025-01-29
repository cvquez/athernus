class CreateRequestLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :request_logs do |t|
      t.string :url, null: false
      t.string :method
      t.text :request_body
      t.text :response_body
      t.integer :response_code
      t.string :content_type
      t.integer :content_length, default: 0
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :initiator, default: 0
      t.text :response_headers

      t.timestamps
    end
  end
end
