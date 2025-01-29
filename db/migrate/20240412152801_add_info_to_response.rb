class AddInfoToResponse < ActiveRecord::Migration[7.0]
  def change
    add_column :responses, :session, :string
    add_column :responses, :ip_address, :string
    add_column :responses, :user_agent, :string
  end
end
