class AddColorToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :color, :string, default: '#ffffff'
  end
end
